Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28142C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Nov 2022 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKOKap (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Nov 2022 05:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKOKan (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2022 05:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659022B0F
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2022 02:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668508183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YICICiRIIvJGLWVnkrUNSolVjsnAqBc/c40p9oqLG/U=;
        b=HrSRAAMR2JdlrkfFixFYmhM5zl4qdZQVHNF0YQL2cJ/oI7BCFqFe6H84FgBBk5dKxDpYXb
        PWSLieZZLC2IwjccDw6A2eMWnn9giY8pzb0EjBIkWXjxxJtXFcxpkTIVnXsKzrO6VwRaM1
        pjvfwHXVoT5VDXv5tkyicDCoM0qikDk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-sJv_NK1QNKW6370em2aWRQ-1; Tue, 15 Nov 2022 05:29:41 -0500
X-MC-Unique: sJv_NK1QNKW6370em2aWRQ-1
Received: by mail-pg1-f197.google.com with SMTP id r126-20020a632b84000000b004393806c06eso7285453pgr.4
        for <fstests@vger.kernel.org>; Tue, 15 Nov 2022 02:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YICICiRIIvJGLWVnkrUNSolVjsnAqBc/c40p9oqLG/U=;
        b=NChkGkFaRYprCcgzNljvxCPzSn8bsl/SjNDNICQXD6v7Mra23nv1qDR0cZV3uqcSz3
         g1eltkyd7ywMxltRpuu76PIHPElSCBduSjIG8UiWUPMreERcZUzsHYMcBxe9zXRultZ3
         oB1GtcUrwmkNl+rq8AkPV4tqBkkXCeV0+G2HlsXAzVuIvYAcIoXqjaxCTccF8/bleFps
         cOuvgJtQKxub9fiqIT1TnhICd84xSvWj1+7UfHp2YxHpu7eu2QXRivOnexK4eIb42uMj
         W1rlhBG40Ah+5ikEAz7iuCtOtVx/mcqMclNjmChlyCzat7+cmfb/XM0swW+XRyItEge3
         pBsQ==
X-Gm-Message-State: ANoB5pnzoilzE9F6XJ2Ik/FTrcil2PEEVi0JU7oJDfv2NfZpIIJDxfqI
        tpnx0vu4Q75hcUzgZWmX80p2U0DspqaSv/3O3Pag2u+0KZQZVZimfOE/+zjSRsuJXoRbmPdii5f
        nBPMGHk6hPsJcDzZkyw==
X-Received: by 2002:a17:903:2342:b0:186:8518:6c79 with SMTP id c2-20020a170903234200b0018685186c79mr3259735plh.146.1668508180084;
        Tue, 15 Nov 2022 02:29:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YXfeh44+jKC9E0GkpfYclGTK6FG8XyrDq6gaRhBRwnGnpZ002J+dxRBScvzjmuXM9fMUSqQ==
X-Received: by 2002:a17:903:2342:b0:186:8518:6c79 with SMTP id c2-20020a170903234200b0018685186c79mr3259722plh.146.1668508179811;
        Tue, 15 Nov 2022 02:29:39 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b001886ff82680sm7039833plm.127.2022.11.15.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:29:39 -0800 (PST)
Date:   Tue, 15 Nov 2022 18:29:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Cc:     djwong@kernel.org, fstests@vger.kernel.org, bfoster@redhat.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified length
Message-ID: <20221115102934.ipfr5juhgav36t3s@zlang-mailbox>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
 <20221114145656.cn5bnvllpwaud2px@zlang-mailbox>
 <1c1b84e5-a33d-199d-dcf2-b4a64d5c6eef@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1b84e5-a33d-199d-dcf2-b4a64d5c6eef@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 15, 2022 at 03:05:10PM +0800, Yang, Xiao/杨 晓 wrote:
> On 2022/11/14 22:56, Zorro Lang wrote:
> > On Mon, Nov 14, 2022 at 08:35:02AM +0000, Xiao Yang wrote:
> > > It is unnecssary to always create a dm-log-writes device
> > > based on the entire size of the target/underlying device.
> > > 
> > > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> > > ---
> > 
> > Darrick has given his RVB [1]:
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > I think you can keep it in this V2 patch.
> 
> Hi Zorro,
> 
> Thanks for your reminder.

np, I've tested and merged this patchset, and will push this weekend.

Thanks,
Zorro

> 
> As Darrick suggested, I actually added a comment to explain the blkdev and
> length arguments. So I hope Darrick can review it again.
> 
> Fortunately, Darrick has added reviewed-by on the v2 patch set. ^_^
> 
> Best Regards,
> Xiao Yang
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > https://lore.kernel.org/fstests/Y3EvUgtux4tP1tdY@magnolia/T/#m83b97790ba6570874f36cd0601747e1b6b155de2
> > 
> > >   common/dmlogwrites | 18 ++++++++++++++++--
> > >   1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/common/dmlogwrites b/common/dmlogwrites
> > > index 9fa1c977..c1c85de9 100644
> > > --- a/common/dmlogwrites
> > > +++ b/common/dmlogwrites
> > > @@ -59,14 +59,28 @@ _require_log_writes_dax_mountopt()
> > >   	fi
> > >   }
> > > +# Set up a dm-log-writes device
> > > +#
> > > +# blkdev: the specified target device
> > > +# length(optional): the mapped length in bytes
> > > +# Note that the entire size of the target device will be used
> > > +# if length is not specified.
> > >   _log_writes_init()
> > >   {
> > > -	blkdev=$1
> > > +	local blkdev=$1
> > > +	local length=$2
> > > +	local BLK_DEV_SIZE
> > >   	[ -z "$blkdev" ] && _fail \
> > >   	"block dev must be specified for _log_writes_init"
> > > -	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> > > +	if [ -z "$length" ]; then
> > > +		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> > > +	else
> > > +		local blksz=`blockdev --getss $blkdev`
> > > +		BLK_DEV_SIZE=$((length / blksz))
> > > +	fi
> > > +
> > >   	LOGWRITES_NAME=logwrites-test
> > >   	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
> > >   	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

