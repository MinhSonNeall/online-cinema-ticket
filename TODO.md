# Implementation Plan for Admin Dashboard Features

This document outlines the tasks required to implement the Showtime, Rooms & Seats, and Ticket Prices management features.

## Phase 1: Showtime Management

- [ ] **Backend:**
    - [ ] Create `ManageShowtimeServlet.java` to handle all showtime-related logic.
    - [ ] Implement `addShowtime` service to handle the creation of new showtimes.
    - [ ] Implement `editShowtime` service to update existing showtimes.
    - [ ] Implement `deleteShowtime` service to remove showtimes from the database.
    - [ ] Create `DaoShowtime.java` with methods for `get`, `add`, `update`, and `delete` operations.
- [ ] **Frontend:**
    - [x] Create `manageShowtime.jsp` to display a list of all showtimes.
    - [ ] Create `addShowtime.jsp` for adding new showtimes.
    - [ ] Create `editShowtime.jsp` for editing existing showtimes.

## Phase 2: Rooms & Seats Management

- [ ] **Backend:**
    - [ ] Create `ManageRoomSeatServlet.java` to handle room and seat management.
    - [ ] Implement services for adding, editing, and deleting rooms and seats.
    - [ ] Create `DaoRoom.java` and `DaoSeat.java` for database operations.
- [ ] **Frontend:**
    - [ ] Create `manageRoomSeat.jsp` to display and manage rooms and seats.

## Phase 3: Ticket Prices Management

- [ ] **Backend:**
    - [ ] Create `ManageTicketPriceServlet.java` to handle ticket price updates.
    - [ ] Implement services for setting and updating ticket prices.
    - [ ] Create `DaoTicketPrice.java` for database operations.
- [ ] **Frontend:**
    - [ ] Create `manageTicketPrice.jsp` to provide an interface for managing ticket prices. 