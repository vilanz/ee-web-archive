use rustler::Binary;

#[rustler::nif]
fn parse_world_data(compressed_data: Binary) -> Binary {
    println!("good luck lol");
    return compressed_data;
}

rustler::init!("Elixir.EEWebArchive.ArchivEE.WorldDataParser");
