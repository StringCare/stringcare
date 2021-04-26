//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <stringcare/stringcare_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) stringcare_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "StringcarePlugin");
  stringcare_plugin_register_with_registrar(stringcare_registrar);
}
