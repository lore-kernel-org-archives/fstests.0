Received: from mx1.redhat.com ([209.132.183.28]:44392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752214AbdKWGOT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Nov 2017 01:14:19 -0500
Date: Thu, 23 Nov 2017 14:14:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/465: just check the actual read data under dio
 read/write
Message-ID: <20171123061417.GR2749@eguan.usersys.redhat.com>
References: <1511248240-15172-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511248240-15172-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 21, 2017 at 03:10:40PM +0800, Xiao Yang wrote:
> I got the following message when running generic/465 on RHEL7.4
> ---------------------------------------------------------------
> QA output created by 465
> non-aio dio test
> encounter an error: block 43 offset 0, content 0
> encounter an error: block 0 offset 4096, content 62
> encounter an error: block 1 offset 0, content 0
> encounter an error: block 17 offset 0, content 0
> aio-dio test
> encounter an error: block 9 offset 0, content 0
> encounter an error: block 2 offset 0, content 0
> encounter an error: block 0 offset 4096, content 62
> encounter an error: block 12 offset 0, content 0
> ---------------------------------------------------------------
> 
> It is possible that dio read reads less than 1M data while dio write
> is writing 1M data into file, because concurrent dio read/write to the
> same file cannot guarantee atomicity and may split specified size.
> Please see this URL for detailed explanation:
> https://marc.info/?l=linux-fsdevel&m=151053542926457&w=2
> 
> We can just check the actual read data instead of the whole read buffer.

I think the bug in the test is real, but it has nothing to do with the
atomicity of direct I/O. (Sorry I misled you previously offline.)

The short version of why you see reader reads less than 1M data is
simply because RHEL7.4 doesn't have the referenced fix in the test,
commit 9fe55eea7 ("Fix race when checking i_size on direct i/o read").

The long version follows. This test is doing append direct write to the
file, and ext4 falls back to buffer write in this case. So the writer
takes exclusive inode lock and does buffer write, which updates i_size
by at most page size in each write cycle (generic_perform_write()). And
on the reader side, due to commit 9fe55eea7, direct read won't fall back
to buffer read, and direct read will block on taking shared inode lock
until the writer releases the lock, so direct read always sees the final
inode size.

But on RHEL7.4, on the other hand, the reader will also fall back to
buffer read, due to lack of the fix, and buffer read doesn't take inode
lock, so it doesn't need to wait for the writer to finish first and sees
the intermediate inode size and returns data less than 1M.

The test needs fix as well (but in a different way), because in ext4
data=journal mode, all direct I/O are falling back to buffer I/O, so you
still could hit the short read case.

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  src/aio-dio-regress/aio-dio-append-write-read-race.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> index 8f94d50..848755c 100644
> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> @@ -46,6 +46,7 @@ struct io_data {
>  };
>  
>  int reader_ready = 0;
> +static volatile int act_rd_sz;

You can introduce a new field in struct io_data to record the return
value of pread in reader thread and do check based on that value in
main().

Thanks,
Eryu

>  
>  static void usage(const char *prog)
>  {
> @@ -57,15 +58,15 @@ static void usage(const char *prog)
>  static void *reader(void *arg)
>  {
>  	struct io_data *data = (struct io_data *)arg;
> -	int ret;
>  
> +	act_rd_sz = 0;
>  	memset(data->buf, 'b', data->blksize);
>  	reader_ready = 1;
>  	do {
> -		ret = pread(data->fd, data->buf, data->blksize, data->offset);
> -		if (ret < 0)
> +		act_rd_sz = pread(data->fd, data->buf, data->blksize, data->offset);
> +		if (act_rd_sz < 0)
>  			perror("read file");
> -	} while (ret <= 0);
> +	} while (act_rd_sz <= 0);
>  
>  	return NULL;
>  }
> @@ -203,7 +204,7 @@ int main(int argc, char *argv[])
>  			goto err;
>  		}
>  
> -		for (j = 0; j < blksize; j++) {
> +		for (j = 0; j < act_rd_sz; j++) {
>  			if (rdata.buf[j] != 'a') {
>  				fail("encounter an error: "
>  					"block %d offset %d, content %x\n",
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
