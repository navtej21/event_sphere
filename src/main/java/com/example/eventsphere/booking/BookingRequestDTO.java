package com.example.eventsphere.booking;


import com.example.eventsphere.attendee.AttendeeDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookingRequestDTO {

    private Long eventId;
    private List<AttendeeDTO> attendees;
}
