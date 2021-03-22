Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB241C433C1
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70D86198E
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVMZh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:25:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVMZb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Mar 2021 08:25:31 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOJcd-0005VB-C2; Mon, 22 Mar 2021 12:25:27 +0000
Date:   Mon, 22 Mar 2021 13:25:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 4/4] xfs/530: quotas on idmapped mounts
Message-ID: <20210322122526.i7fw7e7jzrxg4tsi@wittgenstein>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <20210316103627.2954121-5-christian.brauner@ubuntu.com>
 <YFdde7kuMpPsd3Om@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFdde7kuMpPsd3Om@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 21, 2021 at 10:51:39PM +0800, Eryu Guan wrote:
> On Tue, Mar 16, 2021 at 11:36:27AM +0100, Christian Brauner wrote:
> > This is basically a re-implementation of xfs/050 but each file creation
> > call is done through an idmapped mount which verifies that the semantics
> > are identical even when the mount is idmapped.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: fstests@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v1 */
> > patch not present
> > 
> > /* v2 */
> > patch not present
> > 
> > /* v3 */
> > patch not present
> > 
> > /* v4 */
> > patch not present
> > 
> > /* v5 */
> > patch not present
> > 
> > /* v6 */
> > patch not present
> > 
> > /* v7 */
> > patch not present
> > 
> > /* v8 */
> > patch introduced
> > 
> > /* v9 */
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - Rebased onto current master.
> > ---
> >  tests/xfs/530     | 274 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/530.out | 129 ++++++++++++++++++++++
> >  tests/xfs/group   |   1 +
> >  3 files changed, 404 insertions(+)
> >  create mode 100644 tests/xfs/530
> >  create mode 100644 tests/xfs/530.out
> > 
> > diff --git a/tests/xfs/530 b/tests/xfs/530
> > new file mode 100644
> > index 00000000..9e10c40d
> > --- /dev/null
> > +++ b/tests/xfs/530
> > @@ -0,0 +1,274 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
> > +# All Rights Reserved.
> > +#
> > +# FS QA Test No. 530
> > +#
> > +# Exercises basic XFS quota functionality
> > +#       uquota, gquota, uqnoenforce, gqnoenforce
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/quota
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	_scratch_unmount 2>/dev/null
> > +	rm -f $tmp.*
> > +}
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +
> > +cp /dev/null $seqres.full
> > +chmod a+rwx $seqres.full	# arbitrary users will write here
> > +
> > +_require_scratch
> > +_require_xfs_quota
> > +_require_user fsgqa
> > +
> > +_scratch_mkfs >/dev/null 2>&1
> > +_scratch_mount
> > +bsize=$(_get_file_block_size $SCRATCH_MNT)
> > +_scratch_unmount
> > +
> > +bsoft=$(( 200 * $bsize ))
> > +bhard=$(( 1000 * $bsize ))
> > +isoft=4
> > +ihard=10
> > +
> > +_filter_report()
> 
> Seems this is mostly copied from _filter_quota_report(), just remove the
> $id and $bsize check in the beginning, is it possible to re-use
> _filter_quota_report?

Yeah, I think even without that check I can just directly use
_filter_quota_report. Not sure why I didn't use it right away. Probably
an oversight on my part that it was available as a generic helper.
Thanks for the pointer.

> 
> > +{
> > +	tr -s '[:space:]' | \
> > +	perl -npe '
> > +		s/^\#'$id' /[NAME] /g;
> > +		s/^\#0 \d+ /[ROOT] 0 /g;
> > +		s/6 days/7 days/g' |
> > +	perl -npe '
> > +		$val = 0;
> > +		if ($ENV{'LARGE_SCRATCH_DEV'}) {
> > +			$val = $ENV{'NUM_SPACE_FILES'};
> > +		}
> > +		s/(^\[ROOT\] \S+ \S+ \S+ \S+ \[--------\] )(\S+)/$1@{[$2 - $val]}/g' |
> > +	sed -e 's/ 65535 \[--------\]/ 00 \[--------\]/g' |
> > +	perl -npe '
> > +		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
> > +}
> > +
> > +# The actual point at which limit enforcement takes place for the
> > +# hard block limit is variable depending on filesystem blocksize,
> > +# and iosize.  What we want to test is that the limit is enforced
> > +# (ie. blksize less than limit but not unduly less - ~85% is kind)
> > +# nowadays we actually get much closer to the limit before EDQUOT.
> > +#
> > +_filter_and_check_blks()
> > +{
> > +	perl -npe '
> > +		if (/^\#'$id'\s+(\d+)/ && '$enforce') {
> > +			$maximum = '$bhard';
> > +			$minimum = '$bhard' * 85/100;
> > +			$used = $1 * 1024;
> > +			if (($used < $minimum || $used > $maximum) && '$noextsz') {
> > +				printf(" URK %d: %d is out of range! [%d,%d]\n",
> > +					'$id', $used, $minimum, $maximum);
> > +			}
> > +			s/^(\#'$id'\s+)(\d+)/\1 =OK=/g;
> > +		}
> > +	' | _filter_report
> > +}
> > +
> > +_qsetup()
> > +{
> > +	opt=$1
> > +	enforce=0
> > +	if [ $opt = "u" -o $opt = "uno" ]; then
> > +		type=u
> > +		eval `_choose_uid`
> > +	elif [ $opt = "g" -o $opt = "gno" ]; then
> > +		type=g
> > +		eval `_choose_gid`
> > +	elif [ $opt = "p" -o $opt = "pno" ]; then
> > +		type=p
> > +		eval `_choose_prid`
> > +	fi
> > +	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
> > +
> > +	echo "Using type=$type id=$id" >> $seqres.full
> > +}
> 
> And above two functions are copied from xfs/050 and xfs/299, could you
> please re-factor them into a common helper so they could be shared by
> tests?

Yeah, I've done that.

> 
> > +
> > +_mount_idmapped()
> 
> Seems this could be made into a generic _scratch_mount_idmapped()
> helper.

I've added this as a simpler helper in its current form with the ability
to map a single id for now. We can later add a more complex helper if we
need to but handling variable number of arguments isn't really pleasant
so I'd defer this part until we need it.

> 
> > +{
> > +	if [ "$type" == "u" ]; then
> > +		# This means root will be able to create files as uid %id in
> > +		# the underlying filesystem by going through the idmapped mount.
> > +		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
> > +							 --map-mount u:$id:0:1 \
> > +							 --map-mount g:0:0:1 \
> > +							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
> > +	else
> > +		# This means root will be able to create files as gid %id in
> > +		# the underlying filesystem by going through the idmapped mount.
> > +		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
> > +							 --map-mount g:$id:0:1 \
> > +							 --map-mount u:0:0:1 \
> > +							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
> > +	fi
> > +}
> > +
> > +_umount_idmapped()
> 
> And turn this into _scratch_umount_idmapped()

Added.

> 
> > +{
> > +	# ls -al "$SCRATCH_MNT"
> 
> Could be removed?

Yeah, debugging residual.

> 
> > +	umount -l -q "${SCRATCH_MNT}" >/dev/null 2>&1
> 
> s/umount/$UMOUNT_PROG/. And it'd be good to add some comments to desribe
> why lazy umount is needed.

We don't need the lazy umount. I just use this as my default umount
strategy.

> 
> > +	# ls -al "$SCRATCH_MNT"
> 
> Could be removed?
> 
> > +}
> > +
> > +_exercise()
> 
> Remove the leading "_" for local functions.

Done and rename to run_test()

Thanks!
Christian
