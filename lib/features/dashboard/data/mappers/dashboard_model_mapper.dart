import '../../domain/entities/dashboard_entity.dart';
import '../models/dashboard_model.dart';

extension DashboardModelMapper on DashboardModel {
  DashboardEntity get toEntity {
    final activeTripStatuses = {
      'pendingdriver',
      'driverassigned',
      'driverenroute',
      'driverarrived',
      'inprogress',
    };

    final pendingDrivers = drivers
        .where((driver) => driver.approvalStatus.toLowerCase() != 'approved')
        .take(5)
        .map((driver) => driver.toEntity)
        .toList();
    final pendingTrips = trips
        .where((trip) {
          final status = trip.status.toLowerCase();
          return status == 'pendingdriver' || status == 'scheduled';
        })
        .take(5)
        .map((trip) => trip.toEntity)
        .toList();
    final assignableDrivers = drivers
        .where((driver) {
          return driver.status.toLowerCase() == 'online' &&
              driver.approvalStatus.toLowerCase() == 'approved' &&
              driver.vehicleTypeId != null;
        })
        .map((driver) => driver.toEntity)
        .toList();

    return DashboardEntity(
      totalTrips: trips.length,
      activeTrips: trips
          .where(
            (trip) => activeTripStatuses.contains(trip.status.toLowerCase()),
          )
          .length,
      completedTrips: trips
          .where((trip) => trip.status.toLowerCase() == 'completed')
          .length,
      onlineDrivers: drivers
          .where((driver) => driver.status.toLowerCase() == 'online')
          .length,
      pendingKycDrivers: pendingDrivers.length,
      totalDrivers: drivers.length,
      vehicleTypes: vehicleTypes.map((type) => type.toEntity).toList(),
      recentTrips: trips.take(5).map((trip) => trip.toEntity).toList(),
      pendingTrips: pendingTrips,
      pendingDrivers: pendingDrivers,
      assignableDrivers: assignableDrivers,
      auditLogs: auditLogs.take(6).map((log) => log.toEntity).toList(),
    );
  }
}

extension DashboardVehicleTypeModelMapper on DashboardVehicleTypeModel {
  DashboardVehicleTypeEntity get toEntity {
    return DashboardVehicleTypeEntity(
      id: id,
      code: code,
      name: name,
      capacity: capacity,
      ratePerKm: ratePerKm,
      ratePerMin: ratePerMin,
      minFare: minFare,
      sortOrder: sortOrder,
      isActive: isActive,
    );
  }
}

extension DashboardDriverModelMapper on DashboardDriverModel {
  DashboardDriverEntity get toEntity {
    return DashboardDriverEntity(
      id: id,
      userId: userId,
      fullName: fullName,
      licenseNumber: licenseNumber,
      status: status,
      approvalStatus: approvalStatus,
      vehicleTypeId: vehicleTypeId,
    );
  }
}

extension DashboardUserModelMapper on DashboardUserModel {
  DashboardUserEntity get toEntity {
    return DashboardUserEntity(
      id: id,
      name: name,
      phone: phone,
      email: email,
      role: role,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

extension DashboardSystemConfigModelMapper on DashboardSystemConfigModel {
  DashboardSystemConfigEntity get toEntity {
    return DashboardSystemConfigEntity(
      tripDiscountPercent: tripDiscountPercent,
      currencyCode: currencyCode,
      stripeEnabled: stripeEnabled,
      stripePublishableKey: stripePublishableKey,
    );
  }
}

extension DashboardAdminProfileModelMapper on DashboardAdminProfileModel {
  DashboardAdminProfileEntity get toEntity {
    return DashboardAdminProfileEntity(
      id: id,
      name: name,
      email: email,
      phone1: phone1,
      phone2: phone2,
      isActive: isActive,
    );
  }
}


extension DashboardTripModelMapper on DashboardTripModel {
  DashboardTripEntity get toEntity {
    final ordered = List<DashboardTripStopModel>.of(stops)
      ..sort((a, b) => a.sequence.compareTo(b.sequence));
    final pickup = ordered.firstOrNull;
    final dropoff = ordered.length > 1 ? ordered.last : null;
    return DashboardTripEntity(
      id: id,
      referenceCode: referenceCode,
      status: status,
      vehicleTypeId: vehicleTypeId,
      fareLabel: '${quotedFare.toStringAsFixed(2)} $currencyCode',
      createdAt: createdAt,
      pickupLatitude: pickup?.latitude,
      pickupLongitude: pickup?.longitude,
      pickupLabel: pickup?.label,
      dropoffLabel: dropoff?.label,
      stops: ordered.map((s) => s.toEntity).toList(),
      scheduledAt: scheduledAt,
      assignedAt: assignedAt,
      arrivedAt: arrivedAt,
      startedAt: startedAt,
      completedAt: completedAt,
    );
  }
}

extension DashboardTripStopModelMapper on DashboardTripStopModel {
  DashboardTripStopEntity get toEntity {
    return DashboardTripStopEntity(
      latitude: latitude,
      longitude: longitude,
      label: label,
      sequence: sequence,
    );
  }
}

extension DashboardTripDetailsModelMapper on DashboardTripDetailsModel {
  DashboardTripDetailsEntity get toEntity {
    return DashboardTripDetailsEntity(
      id: id,
      referenceCode: referenceCode,
      passengerName: passengerName,
      passengerPhone: passengerPhone,
      driverName: driverName,
      driverPhone: driverPhone,
      vehicleTypeName: vehicleTypeName,
      status: status,
      fareLabel: '${fare.toStringAsFixed(2)} $currencyCode',
      createdAt: createdAt,
      scheduledAt: scheduledAt,
      assignedAt: assignedAt,
      arrivedAt: arrivedAt,
      startedAt: startedAt,
      completedAt: completedAt,
      stops: stops.map((stop) => stop.toEntity).toList(),
    );
  }
}

extension DashboardAuditLogModelMapper on DashboardAuditLogModel {
  DashboardAuditLogEntity get toEntity {
    return DashboardAuditLogEntity(
      id: id,
      action: action,
      entityName: entityName,
      actorName: actorName,
      createdAt: createdAt,
    );
  }
}

extension DashboardDriverDocumentModelMapper on DashboardDriverDocumentModel {
  DashboardDriverDocumentEntity get toEntity {
    return DashboardDriverDocumentEntity(
      id: id,
      type: type,
      fileUrl: fileUrl,
      status: status,
      reviewNotes: reviewNotes,
      reviewedAt: reviewedAt,
    );
  }
}

extension DashboardDriverLocationModelMapper on DashboardDriverLocationModel {
  DashboardDriverLocationEntity get toEntity {
    return DashboardDriverLocationEntity(
      driverId: driverId,
      name: name,
      phone: phone,
      status: status,
      approvalStatus: approvalStatus,
      latitude: latitude,
      longitude: longitude,
      locationUpdatedAt: locationUpdatedAt,
      vehicleTypeId: vehicleTypeId,
      vehicleTypeName: vehicleTypeName,
    );
  }
}
