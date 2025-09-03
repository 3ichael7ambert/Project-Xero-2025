if (part_system_exists(ps)) part_system_destroy(ps);
part_type_destroy(pt_rain);
part_type_destroy(pt_snow);
part_type_destroy(pt_mist);
if (surface_exists(surf_fog)) surface_free(surf_fog);
ds_list_destroy(splats);
