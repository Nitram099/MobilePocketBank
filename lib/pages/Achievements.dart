import 'package:flutter/material.dart';

class Gamification {
  // Initialize non-nullable instances with default values
  int coins = 0;
  int streak = 0;
  final List<Task> tasks = []; // Use final for an empty, unmodifiable list
  final List<Achievement> achievements = []; // Use final for an empty, unmodifiable list
  Leaderboard? leaderboard; // Make leaderboard nullable

  void awardCoins(int amount) {
    coins += amount;
  }

  void increaseStreak() {
    streak++;
  }

  void resetStreak() {
    streak = 0;
  }

  void completeTask(Task task) {
    tasks.remove(task);
    awardCoins(task.reward);
    checkAchievements(task);
  }

  void checkAchievements(Task task) {
    for (Achievement achievement in achievements) {
      if (achievement.isCompleted(tasks)) {
        awardCoins(achievement.reward);
        // Update leaderboard
      }
    }
  }
}

class Task {
  final String name;
  final int reward;
  bool isCompleted;

  Task({
    required this.name,
    required this.reward,
    this.isCompleted = false,
  });
}

class Achievement {
  final String name;
  final int reward;
  final List<Task> requiredTasks;

  Achievement({
    required this.name,
    required this.reward,
    required this.requiredTasks,
  });

  bool isCompleted(List<Task> completedTasks) {
    return requiredTasks.every((task) => completedTasks.contains(task));
  }
}

class Leaderboard {
  List<User> users;

  Leaderboard({
    required this.users,
  });
}

class User {
  final String id;
  final int points;
  final List<Achievement> unlockedAchievements;

  User({
    required this.id,
    this.points = 0,
    this.unlockedAchievements = const [],
  });
}