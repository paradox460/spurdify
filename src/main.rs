#[macro_use]
extern crate clap;

use clap::{App, AppSettings, Arg};
use spurdify::spurdify;
use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::io::{BufRead, BufReader, BufWriter};
use std::process::exit;

const SPURDO_FACE: &str = r#"
    ▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄▄
   █▒▒░▄▄▀▀▀▀▄░▒░▄▄▄▄▄░▀▀▄
  █▒░▄▀░▒▒▒▒▒░▀▄▀░▒▒▒▒▒▒▒█
 █▒▒▒▒▒▒▒▒▒██▀▒▒▒▒▒▒██▀▄▒█
▄▀▒▒▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▀▀▀▒▒▒█
█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒░░░░░░░▒█
█░▒▒▀▄▄▒░░░░░░▒▄▀▄▄░░░░░░▒█
 █░▒▒▒▒▀▄▄▄▄▄███████▄▄▄▄▄▀
  █░▒▒▒▒▒▒▀▄▀▀████▀▀▄▀▒▒█
   ▀▀▀▄▄▄▄▄▄█▄▄▄▄▄▄█▄▄▄▀"
"#;

fn main() {
  let cli_matches = App::new("spurdify")
    .version(crate_version!())
    .about(format!("Spurdifies text\n{}", SPURDO_FACE).as_str())
    .setting(AppSettings::TrailingVarArg)
    .arg(
      Arg::with_name("file")
        .short("f")
        .long("file")
        .value_name("FILE")
        .help("File to spurdify")
        .takes_value(true),
    )
    .arg(
      Arg::with_name("TEXT")
        .help("Text to spurdify")
        .multiple(true),
    )
    .get_matches();

  let mut writer = BufWriter::new(io::stdout());
  if let Some(text) = cli_matches.values_of("TEXT") {
    let text = spurdify(text.collect::<Vec<_>>().join(" "));
    writeln!(writer, "{}", text).unwrap();
    writer.flush().unwrap();
    exit(0);
  }

  let file: Box<dyn io::Read>;
  let mut is_tty: bool = false;
  if let Some(filename) = cli_matches.value_of("file") {
    file = Box::new(File::open(filename).unwrap());
  } else {
    if atty::is(atty::Stream::Stdin) {
      is_tty = true;
      println!(
        "{}\nType a line and see it spurdified instantly. (run with --help for more information)",
        SPURDO_FACE
      );
    }
    file = Box::new(io::stdin());
  };

  let reader = BufReader::new(file);
  for line in reader.lines() {
    let line = line.unwrap();
    writeln!(writer, "{}", spurdify(line)).unwrap();
    if is_tty {
      writer.flush().unwrap();
    }
  }
}
