#!/use/bin/ruby

# Course: CIS*3260: Software Design IV | Quiz 2: Question 2 - Observer Design Pattern Ruby Code Example
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: December 3, 2021
# Professor: Mark Wineberg
# Language: Ruby

"""
Question 2 (3 points)
Pick one of the 3 patterns and code an example of your choice, other than one from the Design Patterns textbook such as ducks or coffee. You may code using pseudo-code (1 pt bonus if you code it in Ruby)

- I choose to do an Observer Design Patter where the Subject is about a video game topic uch that all subscribed observers are gaming fanatics that want to keep up to date on the latest news about this video game subject
-> With this simple example, I have a VideoGameSubject (that uses a general Subject as an interface) and two observers ProGamer and CasualGamer (that both use a general Observer as an interface) and subscribe to the VideoGameSubject
"""

# =========================== Subject.rb ===========================

# This is a general subject that is abstract and acts like an interface that manages subscribers
# NOTE: This isn't necessary in Ruby since interfaces don't exist, but we'll use it like one because we did something similar in our assignments and the lectures+textboook taught us this way (it used Java-style OOP)
class Subject
    # Attaches an observer to the subject
    def attach(observer)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    # Detaches an observer from the subject
    def detach(observer)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    # Notifies all observers about some kind of event
    def notify
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
end

# ======================= VideoGameSubject.rb =======================

# The VideoGameSubject owns some important state and notifies subscribed observers when the state changes
class VideoGameSubject < Subject
    # For simplicity, the state of the subject, which is essential to all subscribers, is stored in an instance variable for convenient reference when necessary
    attr_accessor :state
    attr_accessor :observers

    # Default constructor that creates a video game subject with an empty list of subscribed observers
    def initialize
        @observers = []
    end

    # Returns the list of subscribed observers after attaching the given new observer
    def attach(observer)
        puts "#{self.class}: Attached an observer"
        @observers << observer
    end

    # Deletes the given observer from the list of subscribed oberservers, returning the removed observer or nil if no match was found
    def detach(observer)
        @observers.delete(observer)
    end

    # Notifies each subscribed observer that an event occured (such as a game content leak for a new update) to each subscribed observer can react to the event (i.e. each subscribed observer will update and react accordingly)
    # NOTE: This represents the observer subscription management (i.e. this method triggers an update in each subscribed observer)
    def notify
        puts "#{self.class}: Notifying observers..."
        @observers.each { |observer| observer.update(self) }
    end

    # This changes the video game subject's state such that it will cause a reaction in all subscribed observers once they are notified
    # NOTE: This represents the typical subscription logic, but is only a simple example - subjects commonly important logic that triggers a notification method whenever something important is about to happen (or after it)
    # -> In this case, the important event is that content news was leaked for the new upcoming video game
    def video_game_content_news_leaked
        puts "\n#{self.class}: There was a new leak for the upcoming new video game!"
        @state = rand(0..10)
        puts "#{self.class}: My state has just changed to: #{@state}"
        self.notify
    end
end

# =========================== Observer.rb ===========================

# This is a general observer that is abstract and acts like an interface that manages observers
# NOTE: This isn't necessary in Ruby since interfaces don't exist, but we'll use it like one because we did something similar in our assignments and the lectures+textboook taught us this way (it used Java-style OOP)
class Observer
    # Receives updates from subjects the observer is subscribed to
    def update(_subject)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
end

# ========================= CasualGamer.rb =========================

# This is a specific/concrete observer that reacts to notification updates from the VideoGameSubject that they are subscribed to (i.e. the observer is attached to the subject)
class CasualGamer < Observer
    # Updates the CasualGamer observer when it reacts to a notification event from a VideoGameSubject it is subscribed to
    # NOTE: Casual gamers only care about the big news items that are high priority (i.e. which mean they only react to the top 3 VideoGameSubject states that are most important)
    def update(subject)
        puts 'CasualGamer: Casually reacted to the event' if subject.state < 3
    end
end

# =========================== ProGamer.rb ===========================

class ProGamer < Observer
    # Updates the ProGamer observer when it reacts to a notification event from a VideoGameSubject it is subscribed to
    # NOTE: Pro gamers care about every update and news info about their game because every detail of information is important (no matter how small or insignificant) because it's their job to stay knowlegeable
    def update(subject)
        puts 'ProGamer: Professionally reacted to the event'
    end
end

# ============================= MAIN.rb =============================

def main
    subject = VideoGameSubject.new

    observer_pro = ProGamer.new
    subject.attach(observer_pro)

    observer_casual = CasualGamer.new
    subject.attach(observer_casual)

    subject.video_game_content_news_leaked
    subject.video_game_content_news_leaked

    subject.detach(observer_pro)

    subject.video_game_content_news_leaked
end

main

"""
Example Output when running Main.rb
-----------------------------------

VideoGameSubject: Attached an observer
VideoGameSubject: Attached an observer

VideoGameSubject: There was a new leak for the upcoming new video game!
VideoGameSubject: My state has just changed to: 1
VideoGameSubject: Notifying observers...
ProGamer: Professionally reacted to the event
CasualGamer: Casually reacted to the event

VideoGameSubject: There was a new leak for the upcoming new video game!
VideoGameSubject: My state has just changed to: 8
VideoGameSubject: Notifying observers...
ProGamer: Professionally reacted to the event

VideoGameSubject: There was a new leak for the upcoming new video game!
VideoGameSubject: My state has just changed to: 5
VideoGameSubject: Notifying observers...
"""
