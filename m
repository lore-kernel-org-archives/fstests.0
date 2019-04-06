Received: from mail-pg1-f194.google.com ([209.85.215.194]:35828 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFMLA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Apr 2019 08:11:00 -0400
Date: Sat, 6 Apr 2019 20:10:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: log-writes: Add new option to replay/find next
 write to sector
Message-ID: <20190406121051.GH2824@desktop>
References: <20190328053507.10191-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328053507.10191-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 01:35:07PM +0800, Qu Wenruo wrote:
> For kernel operation we have METADATA/FUA/FLUSH flags as a beacon, but
> for user space write we don't have any useful flag unless the user space
> tool call fsync() to generate a FLUSH bio.
> 
> This means for user space write, we don't really have an equivalent of
> --next-fua to find super block write.
> 
> So this patch will add a new option, --next-write <sector> to
> replay/find next write to certain sector.
> And normally the <sector> should be super block sector number.
> 
> With that, we can replay to super block write even it's user space
> triggering the write.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This lools fine to me. But I'd like Josef or Amir to take a look at it
too, I think they're more familiar with log-writes infrastructure than
me :)

Thanks,
Eryu

> ---
>  src/log-writes/replay-log.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
> index c16df40e5741..0d0ec49c8a00 100644
> --- a/src/log-writes/replay-log.c
> +++ b/src/log-writes/replay-log.c
> @@ -9,6 +9,7 @@
>  enum option_indexes {
>  	NEXT_FLUSH,
>  	NEXT_FUA,
> +	NEXT_WRITE,
>  	START_ENTRY,
>  	END_MARK,
>  	LOG,
> @@ -28,6 +29,7 @@ enum option_indexes {
>  static struct option long_options[] = {
>  	{"next-flush", no_argument, NULL, 0},
>  	{"next-fua", no_argument, NULL, 0},
> +	{"next-write", required_argument, NULL, 0},
>  	{"start-entry", required_argument, NULL, 0},
>  	{"end-mark", required_argument, NULL, 0},
>  	{"log", required_argument, NULL, 0},
> @@ -53,6 +55,8 @@ static void usage(void)
>  	fprintf(stderr, "\t--limit <number> - number of entries to replay\n");
>  	fprintf(stderr, "\t--next-flush - replay to/find the next flush\n");
>  	fprintf(stderr, "\t--next-fua - replay to/find the next fua\n");
> +	fprintf(stderr, "\t--next-write <sector> - replay to/find the next "
> +			"write to <sector>\n");
>  	fprintf(stderr, "\t--start-entry <entry> - start at the given "
>  		"entry #\n");
>  	fprintf(stderr, "\t--start-mark <mark> - mark to start from\n");
> @@ -139,6 +143,7 @@ int main(int argc, char **argv)
>  	char *logfile = NULL, *replayfile = NULL, *fsck_command = NULL;
>  	struct log_write_entry *entry;
>  	u64 stop_flags = 0;
> +	u64 stop_sector = 0;
>  	u64 start_entry = 0;
>  	u64 start_sector = 0;
>  	u64 end_sector = -1ULL;
> @@ -173,6 +178,14 @@ int main(int argc, char **argv)
>  		case NEXT_FUA:
>  			stop_flags |= LOG_FUA_FLAG;
>  			break;
> +		case NEXT_WRITE:
> +			stop_sector = strtoull(optarg, &tmp, 0);
> +			if (tmp && *tmp != '\0') {
> +				fprintf(stderr, "Invalid sector number\n");
> +				exit(1);
> +			}
> +			tmp = NULL;
> +			break;
>  		case START_ENTRY:
>  			start_entry = strtoull(optarg, &tmp, 0);
>  			if (tmp && *tmp != '\0') {
> @@ -324,7 +337,8 @@ int main(int argc, char **argv)
>  		while ((ret = log_seek_next_entry(log, entry, 1)) == 0) {
>  			num_entries++;
>  			if ((run_limit && num_entries == run_limit) ||
> -			    should_stop(entry, stop_flags, end_mark)) {
> +			    should_stop(entry, stop_flags, end_mark) ||
> +			    (stop_sector && entry->sector == stop_sector)) {
>  				printf("%llu@%llu\n",
>  				       (unsigned long long)log->cur_entry - 1,
>  				       log->cur_pos / log->sectorsize);
> -- 
> 2.21.0
> 
