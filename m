Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34111 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaHOKmf convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 15 Aug 2014 06:42:35 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so2126869lab.40
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2014 03:42:33 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 2/2] xfstest: ext4/307 cleanup
In-Reply-To: <alpine.LFD.2.00.1408141618330.2267@localhost.localdomain>
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org> <1407944188-4099-2-git-send-email-dmonakhov@openvz.org> <alpine.LFD.2.00.1408141618330.2267@localhost.localdomain>
Date: Fri, 15 Aug 2014 14:42:30 +0400
Message-ID: <87ppg2c9ux.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Thu, 14 Aug 2014 16:22:35 +0200 (CEST), Lukáš Czerner <lczerner@redhat.com> wrote:
> On Wed, 13 Aug 2014, Dmitry Monakhov wrote:
> 
> > Date: Wed, 13 Aug 2014 19:36:28 +0400
> > From: Dmitry Monakhov <dmonakhov@openvz.org>
> > To: fstests@vger.kernel.org
> > Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
> > Subject: [PATCH 2/2] xfstest: ext4/307 cleanup
> > 
> >  tests/ext4/307:
> >  - test various block sizes
> >  src/e4compact.c:
> >  - fix incorrect offset for donor file
> >  - add support for tunable block size
> 
> Seems like those are two separate problems and should be in separate
> patches.
Ok. No problem I'll separate it in two patches.
> 
> Also I do not particularly like the idea of adding multiple block
> size test to every test there is in xfstests. There is
> MKFS_OPTIONS for that to do exactly this globally. And this
> particular test does not really seem to require different block
> sizes.
Ok. But unfortunately _scratch_mkfs_sized ignores $MKFS_OPT and
require explicit block size parameter (and use 4096 BS by default)
In fact all existing users of this function use default blocksize value.
(which is bad because IMHO). I'll have to change _scratch_mkfs_sized in
order to respect $MKFS_OPT parameters
> -Lukas
> 
> 
> > 
> > Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> > ---
> >  src/e4compact.c    |   22 +++++++++++++++++-----
> >  tests/ext4/307     |   16 +++++++++++-----
> >  tests/ext4/307.out |   13 +++++++++++++
> >  3 files changed, 41 insertions(+), 10 deletions(-)
> > 
> > diff --git a/src/e4compact.c b/src/e4compact.c
> > index de0aeb6..c0284ff 100644
> > --- a/src/e4compact.c
> > +++ b/src/e4compact.c
> > @@ -48,6 +48,8 @@ struct donor_info
> >  	__u64 length;
> >  };
> >  
> > +static long page_size;
> > +static long block_size;
> >  static int ignore_error = 0;
> >  static int verbose = 0;
> >  
> > @@ -64,7 +66,6 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
> >  	mv_ioc.donor_fd = donor->fd;
> >  	mv_ioc.orig_start = start;
> >  	mv_ioc.donor_start = donor->offset;
> > -	mv_ioc.moved_len = 0;
> >  	mv_ioc.len = len;
> >  
> >  	if (verbose)
> > @@ -77,6 +78,7 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
> >  	do {
> >  		i++;
> >  		errno = 0;
> > +		mv_ioc.moved_len = 0;
> >  		ret = ioctl(fd, EXT4_IOC_MOVE_EXT, &mv_ioc);
> >  		if (verbose)
> >  			printf("process %s  it:%d start:%lld len:%lld donor:%lld,"
> > @@ -102,12 +104,12 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
> >  		assert(mv_ioc.len >= mv_ioc.moved_len);
> >  		mv_ioc.len -= mv_ioc.moved_len;
> >  		mv_ioc.orig_start += mv_ioc.moved_len;
> > -		mv_ioc.donor_start = mv_ioc.orig_start;
> > +		mv_ioc.donor_start += mv_ioc.moved_len;
> >  		moved += mv_ioc.moved_len;
> > -
> >  	} while (mv_ioc.len);
> >  
> > -	if (ret && (errno == EBUSY || errno == ENODATA))
> > +	if (ret && ignore_error &&
> > +	    (errno == EBUSY || errno == ENODATA || errno == EOPNOTSUPP))
> >  		ret = 0;
> >  	donor->length -= moved;
> >  	donor->offset += moved;
> > @@ -133,9 +135,16 @@ int main(int argc, char **argv)
> >  	extern int optind;
> >  	int c;
> >  	char * donor_name = NULL;
> > +	int blk_per_pg;
> >  	donor.offset = 0;
> > -	while ((c = getopt(argc, argv, "f:o:iv")) != -1) {
> > +
> > +	page_size = sysconf(_SC_PAGESIZE);
> > +	block_size = page_size;
> > +
> > +	while ((c = getopt(argc, argv, "b:f:o:iv")) != -1) {
> >  		switch (c) {
> > +		case 'b':
> > +			block_size = atol(optarg);
> >  		case 'o':
> >  			donor.offset = atol(optarg);
> >  			break;
> > @@ -167,6 +176,7 @@ int main(int argc, char **argv)
> >  	if (donor.offset)
> >  		donor.offset /= st.st_blksize;
> >  
> > +	blk_per_pg = page_size / block_size;
> >  	if (verbose)
> >  		printf("Init donor :%s off:%lld len:%lld\n", argv[1], donor.offset, donor.length);
> >  	while ((read = getline(&line, &len, stdin)) != -1) {
> > @@ -194,6 +204,8 @@ int main(int argc, char **argv)
> >  
> >  		}
> >  		if (st.st_size && st.st_blocks) {
> > +
> > +			donor.offset =  (donor.offset + blk_per_pg -1) & ~(blk_per_pg -1);
> >  			ret = do_defrag_one(fd, line, 0,
> >  					    (st.st_size  + st.st_blksize-1)/
> >  					    st.st_blksize, &donor);
> > diff --git a/tests/ext4/307 b/tests/ext4/307
> > index 081f819..ee20f61 100755
> > --- a/tests/ext4/307
> > +++ b/tests/ext4/307
> > @@ -39,7 +39,11 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
> >  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> >  _workout()
> >  {
> > +	blk_sz=$1
> >  	echo ""
> > +	echo " Start test for $blk_sz blocksize "
> > +	_scratch_mkfs_sized $((512 * 1024 * 1024)) $blk_sz >> $seqres.full 2>&1
> > +	_scratch_mount
> >  	echo "Run fsstress"
> >  	out=$SCRATCH_MNT/fsstress.$$
> >  	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 $FSSTRESS_AVOID -d $out`
> > @@ -52,9 +56,12 @@ _workout()
> >  	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> >  	echo "Perform compacting"
> >  	cat $out.list | run_check $here/src/e4compact \
> > -		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> > +		-i -v -b $blk_sz -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> > +	$XFS_IO_PROG -c "fiemap" -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> >  	echo "Check data"
> >  	run_check md5sum -c $out.md5sum
> > +	_scratch_unmount
> > +	_check_scratch_fs
> >  }
> >  
> >  # real QA test starts here
> > @@ -65,9 +72,8 @@ _need_to_be_root
> >  _require_scratch
> >  _require_defrag
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > -_scratch_mount
> > -
> > -_workout
> > +_workout 4096
> > +_workout 2048
> > +_workout 1024
> >  status=0
> >  exit
> > diff --git a/tests/ext4/307.out b/tests/ext4/307.out
> > index f48e9f3..9cbd1ab 100644
> > --- a/tests/ext4/307.out
> > +++ b/tests/ext4/307.out
> > @@ -1,5 +1,18 @@
> >  QA output created by 307
> >  
> > + Start test for 4096 blocksize 
> > +Run fsstress
> > +Allocate donor file
> > +Perform compacting
> > +Check data
> > +
> > + Start test for 2048 blocksize 
> > +Run fsstress
> > +Allocate donor file
> > +Perform compacting
> > +Check data
> > +
> > + Start test for 1024 blocksize 
> >  Run fsstress
> >  Allocate donor file
> >  Perform compacting
> > 
