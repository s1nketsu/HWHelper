# HWHelper

> An iOS app that helps teachers manage their students, groups, and homework assignments in one place.

⚠️ Work in progress — this is an early-stage pet project. Features and architecture are evolving.

## About

HWHelper is a personal project aimed at solving a real pain point for tutors and teachers: keeping track of who studies in which group, what homework was assigned, and when it's due. Most teachers I know still juggle this in notebooks, chats, and spreadsheets.

The goal is to build a clean, native iOS experience for teachers — and eventually extend it into a two-sided product where students can log in to see their assignments.

## Current features

- Create and manage groups of students
- Add individual (1-on-1) students
- Record homework assignments per group or per student
- Local storage of all data

## Roadmap

### Short term
- Polish the teacher-facing UI/UX
- Add notifications and reminders for upcoming deadlines
- Calendar view for assignments
- Attach files/images to homework

### Long term
- Backend on Vapor (Swift on the server) to sync data and enable multi-device usage
- Student role — students log in with their own credentials, see assignments from their teacher, and mark homework as done
- Push notifications for new assignments
- Basic teacher–student messaging

## Tech stack

- Language: Swift
- UI: UIKit
- Architecture: MVVM
- Persistence: (local storage — TBD: CoreData)
- Backend (planned): Vapor

## Why this project

Two reasons:
1. A friend who teaches asked for something like this — and nothing on the App Store really fit.
2. I wanted a sandbox to play with modern Swift on both client and server (Vapor) without the constraints of a corporate codebase.

## Status

Active development, evenings and weekends. No release timeline yet — this is a learning playground first, a product second.

## Contact

Built by [Aleksandr Polishchuk](https://github.com/s1nketsu)
Feedback, ideas, and questions welcome — open an issue or reach out on Telegram [@s1nketsu](https://t.me/s1nketsu).
