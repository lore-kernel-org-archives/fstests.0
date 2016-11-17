Received: from mail-it0-f51.google.com ([209.85.214.51]:38452 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbcKQSOP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Nov 2016 13:14:15 -0500
Received: by mail-it0-f51.google.com with SMTP id j191so67652298ita.1
        for <fstests@vger.kernel.org>; Thu, 17 Nov 2016 10:14:15 -0800 (PST)
Date: Thu, 17 Nov 2016 10:14:12 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] generic: test concurrent non-overlapping direct I/O on
 the same extents
Message-ID: <20161117181412.GA21816@vader.DHCP.thefacebook.com>
References: <1edb45d8895de8fe347e800a5fd22b0f6eafb181.1479342541.git.osandov@fb.com>
 <20161117052611.GX27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161117052611.GX27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 17, 2016 at 01:26:11PM +0800, Eryu Guan wrote:
> On Wed, Nov 16, 2016 at 04:29:34PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There have been a couple of logic bugs in `btrfs_get_extent()` which
> > could lead to spurious -EEXIST errors from read or write. This test
> > exercises those conditions by having two threads race to add an extent
> > to the extent map.
> > 
> > This is fixed by Linux commit 8dff9c853410 ("Btrfs: deal with duplciates
> > during extent_map insertion in btrfs_get_extent") and the patch "Btrfs:
> > deal with existing encompassing extent map in btrfs_get_extent()"
> > (http://marc.info/?l=linux-btrfs&m=147873402311143&w=2).
> > 
> > Although the bug is Btrfs-specific, nothing about the test is.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> [snip]
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_xfs_io_command "falloc"
> > +_require_test_program "dio-interleaved"
> > +
> > +extent_size="$(($(stat -f -c '%S' "$TEST_DIR") * 2))"
> 
> There's a helper to get fs block size: "get_block_size".
> 
> > +num_extents=1024
> > +testfile="$TEST_DIR/$$-testfile"
> > +
> > +truncate -s 0 "$testfile"
> 
> I prefer using xfs_io to do the truncate, 
> 
> $XFS_IO_PROG -fc "truncate 0" "$testfile"
> 
> Because in rare cases truncate(1) may be unavailable, e.g. RHEL5,
> usually it's not a big issue, but xfs_io works all the time, we have a
> better way, so why not :)
> 
> > +for ((off = 0; off < num_extents * extent_size; off += extent_size)); do
> > +	xfs_io -c "falloc $off $extent_size" "$testfile"
> 
> Use $XFS_IO_PROG not bare xfs_io.
> 
> I can fix all the tiny issues at commit time.
> 
> Thanks,
> Eryu

Thank you, Eryu, that's all okay with me. I also had a typo here:

diff --git a/src/dio-interleaved.c b/src/dio-interleaved.c
index 831a191..6b04c99 100644
--- a/src/dio-interleaved.c
+++ b/src/dio-interleaved.c
@@ -58,7 +58,7 @@ int main(int argc, char **argv)
 	int fd;
 
 	if (argc != 4) {
-		fprintf(stderr, "usage: %s SECTORSIZE NUM_EXTENTS PATH\n",
+		fprintf(stderr, "usage: %s EXTENT_SIZE NUM_EXTENTS PATH\n",
 			argv[0]);
 		return EXIT_FAILURE;
 	}


Feel free to fix this at commit time, too, or I can send a v2 if you
prefer.

-- 
Omar
