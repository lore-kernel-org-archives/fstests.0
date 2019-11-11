Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A2C43331
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5021783
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKO33 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:29:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:40792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKKO32 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Nov 2019 09:29:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 399B6AC9A;
        Mon, 11 Nov 2019 14:29:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 870001E47E5; Mon, 11 Nov 2019 15:29:26 +0100 (CET)
Date:   Mon, 11 Nov 2019 15:29:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] generic/050: Handle xfs quota special case with
 different output
Message-ID: <20191111142926.GD13307@quack2.suse.cz>
References: <20191105131922.24848-1-jack@suse.cz>
 <20191105131922.24848-3-jack@suse.cz>
 <20191110141052.GE8664@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110141052.GE8664@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun 10-11-19 22:10:54, Eryu Guan wrote:
> [cc'ed Darrick for his inputs, if there's any]
> >  fi
> >  _link_out_file "$features"
> >  
> >  _scratch_mkfs >/dev/null 2>&1
> >  
> > -filter_ro_mount() {
> > -	local arg=""
> > -
> > -	if [ -n "$expect_mount_failure" ]; then
> > -		arg="s|mount: $SCRATCH_MNT: permission denied|mount: device write-protected, mounting read-only|g"
> > -	fi
> > -	sed -e "$arg" | _filter_ro_mount
> > -}
> > -
> > -# Mounting with quota on XFS requires a writable fs, which means
> > -# we expect to fail the ro blockdev test with with EPERM.
> > -expect_mount_failure=
> > -if [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
> > -	expect_mount_failure=1
> > -fi
> > -
> >  #
> >  # Mark the device read-only
> >  #
> > @@ -70,7 +58,7 @@ blockdev --setro $SCRATCH_DEV
> >  # Mount it, and make sure we can't write to it, and we can unmount it again
> >  #
> >  echo "mounting read-only block device:"
> > -_try_scratch_mount 2>&1 | filter_ro_mount
> > +_try_scratch_mount 2>&1 | _filter_ro_mount
> >  if [ "${PIPESTATUS[0]}" -eq 0 ]; then
> 
> But I think we could remove above check as a whole, just do
> 
> _try_scratch_mount 2>&1 | _filter_ro_mount
> echo "touching file on read-only filesystem (should fail)"
> touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> echo "unmounting read-only filesystem"
> _scratch_unmount 2>&1 | _filter_scratch
> 
> as what we did prior to commit b0415daaa968 ("generic/050: fix ro
> blockdev mount of xfs with quota").

Your suggestion looks good to me. I'll update the patch, test, and resend.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
