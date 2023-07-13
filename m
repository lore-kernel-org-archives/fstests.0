Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0CAC0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 08:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGMIcv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjGMIc1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 04:32:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600006A41
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 01:23:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1BFB91F45E;
        Thu, 13 Jul 2023 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689236619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XU6BkQif3uIBgx4t1NMFBnFhjRe6fV/OAzVm8w3v1Y=;
        b=MDJPtkRZO0mbdJwTpz1L7uona89HgUoKL+vYFqUIvy05e0t5jcrPv/hE88iVmjtWFpIItl
        1vN0MTLzSqJX91rzQggozxU/tt+kHiJaECbjTkswjhR5fEell6i9it/2ww3HAlzhUQdJ8f
        exOYmImSPv+lNj24hiRNoEaIBFh7MRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689236619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XU6BkQif3uIBgx4t1NMFBnFhjRe6fV/OAzVm8w3v1Y=;
        b=Pe04fIyrMpfk7FnJuGp6nrIvxYA9RAGCeezWRcb5QIKgxHNfTHB2GZDE6s33yerF3/HQou
        ndh4TXcdhPIYNgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D83A1133D6;
        Thu, 13 Jul 2023 08:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zBeUMYq0r2QYLAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 13 Jul 2023 08:23:38 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e340a96c;
        Thu, 13 Jul 2023 08:23:32 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: cleanup old .kmemleak files
References: <20230712145101.4286-1-lhenriques@suse.de>
        <20230712163500.5871-1-lhenriques@suse.de>
        <20230712220631.GF11442@frogsfrogsfrogs>
Date:   Thu, 13 Jul 2023 09:23:32 +0100
In-Reply-To: <20230712220631.GF11442@frogsfrogsfrogs> (Darrick J. Wong's
        message of "Wed, 12 Jul 2023 15:06:31 -0700")
Message-ID: <87ilaote2j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Jul 12, 2023 at 05:35:00PM +0100, Lu=C3=ADs Henriques wrote:
>> I've spent a non-negligible amount of time looking into a kmemleak that
>> didn't exist in the code I was testing because there was an old .kmemleak
>> file in the results directory.  I don't think this is an intended behavi=
our,
>> so I'm proposing to remove these files everytime we capture the result o=
f a
>> new scan.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  common/rc | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> Changes since v1:
>> I realised that _capture_kmemleak() is called with /dev/null as argument=
, so
>> this version is probably better.
>>=20
>> diff --git a/common/rc b/common/rc
>> index 741579af82d2..6850889e815e 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4433,6 +4433,8 @@ _capture_kmemleak()
>>  	local kern_knob=3D"$DEBUGFS_MNT/kmemleak"
>>  	local leak_file=3D"$1"
>>=20=20
>> +	[ -f "$leak_file" ] && rm -f "$leak_file"
>
> I was hoping you'd incorporate the comment explaining why the test uses
> -f and not -e.

You're right.  The reason I didn't was because I sent out v2 before seeing
your email.  Anyway, I'll send out v3 in a second.  And thanks for the
review, by the way!

Cheers,
--=20
Lu=C3=ADs

>
> --D
>
>> +
>>  	# Tell the kernel to scan for memory leaks.  Apparently the write
>>  	# returns before the scan is complete, so do it twice in the hopes
>>  	# that twice is enough to capture all the leaks.
