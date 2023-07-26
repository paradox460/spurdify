use std::env;
use std::fs;
use std::path::Path;

fn main() {
  let out_dir = env::var_os("OUT_DIR").unwrap();
  let dest_path = Path::new(&out_dir).join("replacements.in");

  let (rules, replacements): (Vec<&str>, Vec<&str>) = [
    ("spurdo", "spurdo"),
    ("sparde", "spärde"),
    ("kek", "geg"),
    ("epic", "ebin"),
    ("right", "rite"),
    ("your", "ur"),
    ("god", "dog"),
    ("linux", "linugs"),
    ("fucking", "fuggin"),
    ("are", "r"),
    ("you", "u"),
    ("wh", "w"),
    ("th", "d"),
    ("af", "ab"),
    ("ap", "ab"),
    ("ca", "ga"),
    ("ck", "gg"),
    ("co", "go"),
    ("ev", "eb"),
    ("ex", "egz"),
    ("et", "ed"),
    ("iv", "ib"),
    ("it", "id"),
    ("ke", "ge"),
    ("nt", "nd"),
    ("op", "ob"),
    ("ot", "od"),
    ("po", "bo"),
    ("pe", "be"),
    ("pi", "bi"),
    ("up", "ub"),
    ("va", "ba"),
    ("cr", "gr"),
    ("kn", "gn"),
    ("lt", "ld"),
    ("mm", "m"),
    ("nt", "dn"),
    ("pr", "br"),
    ("ts", "dz"),
    ("tr", "dr"),
    ("bs", "bz"),
    ("ds", "dz"),
    ("es", "es"),
    ("fs", "fz"),
    ("gs", "gz"),
    ("is", "iz"),
    ("as", "az"),
    ("ls", "lz"),
    ("ms", "mz"),
    ("ns", "nz"),
    ("rs", "rz"),
    ("ss", "sz"),
    ("ts", "tz"),
    ("us", "uz"),
    ("ws", "wz"),
    ("ys", "yz"),
    ("alk", "olk"),
    ("ing", "ign"),
    ("ic", "ig"),
    ("ng", "nk"),
    ("p", "b"),
    ("gge", "gbe"),
  ]
  .iter()
  .cloned()
  .unzip();

  let rules_str = rules
    .iter()
    .fold("".to_string(), |acc, &rule| format!("{}\"{}\",", acc, rule));
  let replacements_str = replacements
    .iter()
    .fold("".to_string(), |acc, &replacement| {
      format!("{}\"{}\",", acc, replacement)
    });
  fs::write(
    &dest_path,
    format!(
      r#"
const RULES: [&str; {}]= [{}];
const REPLACEMENTS: [&str; {}] = [{}];
    "#,
      rules.len(), rules_str,
      replacements.len(), replacements_str
    ),
  )
  .unwrap();
}
