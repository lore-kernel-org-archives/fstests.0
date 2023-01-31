Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23AC636CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjAaMqs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAaMqr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:46:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17C4B892
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:46:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4137B228A8;
        Tue, 31 Jan 2023 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675169197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKBVc2w1sNr8jBRq7qFk8Z59LmfZ9AmDRKi4eekdhIo=;
        b=hnmcaNXNgT41dr+f+Q9P2/F2auCq00Y0Wx8Cz7GF8Qm3IlnsewLSsex86Vs4bvI75KBGMU
        /LIhXerczA88uD48d1BIbftcnEAG7/GeILkez28lTDbl1ztqlbsPBrgsBQ1Tb6AlxGB7ND
        KACkuCkd5s/rTMeo1IupMIChdnZG8pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675169197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dKBVc2w1sNr8jBRq7qFk8Z59LmfZ9AmDRKi4eekdhIo=;
        b=K5pDNXBxNAmNv5MDl8J2diWQPBdQwF2rbG0KpcdMUQ2EIUtsnE8fnXkNPZBKA0Gz9ivkm2
        YhfA1hrfjIRivKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C94513585;
        Tue, 31 Jan 2023 12:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ff4IA60N2WMTFAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:46:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 575B2A06D5; Tue, 31 Jan 2023 13:46:35 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:46:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [PATCH v2] generic/707: Test moving directory while being grown
Message-ID: <20230131124635.3oih5pqk3uhwdbo3@quack3>
References: <20230130145639.30027-1-jack@suse.cz>
 <20230130160401.aeqxpsn5ndbhiraf@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130160401.aeqxpsn5ndbhiraf@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue 31-01-23 00:04:01, Zorro Lang wrote:
> On Mon, Jan 30, 2023 at 03:56:39PM +0100, Jan Kara wrote:
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +_supported_fs generic
> > +_require_scratch
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +_cleanup()
> > +{
> > +	if [ -n "$BGPID" ]; then
> > +		# Stop background process
> > +		kill -9 $BGPID &>/dev/null
> > +		wait
> > +	fi
> 
> Neet to keep the code in common/preamble:_cleanup(), if you cover it:
> 
>         cd /
>         rm -f $tmp.*
> 
> especially you use pushd and popd.

OK, done.

> I forgot to ask, is this case written for someone known fix or change? If so,
> better to use _fixed_by_kernel_commit or _wants_kernel_commit.

Yes, good point. It tests for UDF & ext4 corruption issue. Ext4 commit is
not yet merged but I'll add there something.

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
> > +	BGPID=""
> 
> unset BGPID might be better, but anyway :)

Yeah, nicer. Done.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
