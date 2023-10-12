Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4FCDB46E
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Oct 2023 14:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjJLOJJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Oct 2023 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJLOJI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2023 10:09:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF16B7
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2023 07:09:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6CE72185D;
        Thu, 12 Oct 2023 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697119743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31O4Q4fk2PZOIZiEx7Ms3Dn29nRgUdzl3YTF6KAa0ko=;
        b=VrF7dryHJrSMGRYavzwlVr22BC7pvzDiafH97Og6hrdTfl1UWtcGuMtOkFXEPIpfKwivd3
        xm6cxL7jSobMDQ3V62LQ7Hk06UYzguOEYDFTdLbKYx9iknZAKqoQ4d1zcx5n6XUAYICvuv
        hCU9kAHddgO1JtmebhkL+k1Dx6nz5hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697119743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31O4Q4fk2PZOIZiEx7Ms3Dn29nRgUdzl3YTF6KAa0ko=;
        b=6N0QEHlaBSFaW2euY06It9bYtVT3riYUHz9IZkf53yzxC9WrCxnRQhA0Eg9D3iTM3eCFOk
        WRHgBruBrI0S2SCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B65D6139ED;
        Thu, 12 Oct 2023 14:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vAt8LP/9J2VLCwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 14:09:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 32506A06B0; Thu, 12 Oct 2023 16:09:03 +0200 (CEST)
Date:   Thu, 12 Oct 2023 16:09:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/707: Test moving directory while being grown
Message-ID: <20231012140903.tuwphwhp7fh7podq@quack3>
References: <20230131125416.16120-1-jack@suse.cz>
 <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spamd-Result: default: False [-6.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue 31-01-23 22:25:44, Zorro Lang wrote:
> On Tue, Jan 31, 2023 at 01:54:16PM +0100, Jan Kara wrote:
> > Test how the filesystem can handle moving a directory to a different
> > directory (so that parent pointer gets updated) while it is grown. Ext4
> > and UDF had a bug where if the directory got converted to a different
> > type due to growth while rename is running, the filesystem got
> > corrupted.
> > 
> > Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Thanks, this version looks good to me,
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Guys, I have just noticed this patch didn't get merged. Can you please pick
it up? Thanks!

								Honza

> 
> >  tests/generic/707     | 70 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/707.out |  2 ++
> >  2 files changed, 72 insertions(+)
> >  create mode 100755 tests/generic/707
> >  create mode 100644 tests/generic/707.out
> > 
> > diff --git a/tests/generic/707 b/tests/generic/707
> > new file mode 100755
> > index 000000000000..ad1592a1b957
> > --- /dev/null
> > +++ b/tests/generic/707
> > @@ -0,0 +1,70 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Jan Kara, SUSE Linux.  All Rights Reserved.
> > +#
> > +# FS QA Test 707
> > +#
> > +# This is a test verifying whether the filesystem can gracefully handle
> > +# modifying of a directory while it is being moved, in particular the cases
> > +# where directory format changes
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +_supported_fs generic
> > +_require_scratch
> > +
> > +_fixed_by_kernel_commit f950fd052913 \
> > +	"udf: Protect rename against modification of moved directory"
> > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > +	"ext4: fix possible corruption when moving a directory"
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +	if [ -n "$BGPID" ]; then
> > +		# Stop background process
> > +		kill -9 $BGPID &>/dev/null
> > +		wait
> > +	fi
> > +}
> > +
> > +# Loop multiple times trying to hit the race
> > +loops=$((100*TIME_FACTOR))
> > +files=500
> > +moves=500
> > +
> > +create_files()
> > +{
> > +	# We use slightly longer file name to make directory grow faster and
> > +	# hopefully convert between various types
> > +	for (( i = 0; i < $files; i++ )); do
> > +		touch somewhatlongerfilename$i
> > +	done
> > +}
> > +
> > +for (( i = 0; i <= $moves; i++ )); do
> > +	mkdir $SCRATCH_MNT/dir$i
> > +done
> > +
> > +for (( l = 0; l < $loops; l++ )); do
> > +	mkdir $SCRATCH_MNT/dir0/dir
> > +	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
> > +	create_files &
> > +	BGPID=$!
> > +	popd &>/dev/null
> > +	for (( i = 0; i < $moves; i++ )); do
> > +		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
> > +	done
> > +	wait
> > +	unset BGPID
> > +	rm -r $SCRATCH_MNT/dir$moves/dir
> > +done
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/707.out b/tests/generic/707.out
> > new file mode 100644
> > index 000000000000..8e57a1d8c971
> > --- /dev/null
> > +++ b/tests/generic/707.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 707
> > +Silence is golden
> > -- 
> > 2.35.3
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
