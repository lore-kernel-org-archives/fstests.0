Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29069FC6165
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Aug 2023 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbjHYOB7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Aug 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbjHYOBl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2023 10:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895126AF
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692972018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjxak9bo89OebQVshAcR8xV4lyZfu4tcklNih1ULQqY=;
        b=b1JPC4LnQaj92bF+cUA0RywG0WcseAWx1C18v8z3Nw9oupKDeCTaQ3KLMHSaX83GKt20LW
        8zkKTaKnx3EkvhCCM4YxmV21kcONCVGyGc7BR5lzMq/XN43gkvDUhTmn3v97lablNPDjDZ
        nqjTesbas/6aYzHT3Qi2JVRFEHmcSx8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-9sh6DAqYNaSNTzVwRno29g-1; Fri, 25 Aug 2023 10:00:16 -0400
X-MC-Unique: 9sh6DAqYNaSNTzVwRno29g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68a48df712bso1097568b3a.3
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972015; x=1693576815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjxak9bo89OebQVshAcR8xV4lyZfu4tcklNih1ULQqY=;
        b=BGeWpGx42IG2YSWL6uQvbIhd9rrNNVdf1HlsJ5X6PmUASPjGVjg2Np7ggTb8BXwKXE
         HB6KgSZ3gKUCNCpD1SdCqOAdA0LFRIergSjqRG9XXhUG6pYEVDsjEtwLm9gECYjVQSZP
         ZgogfjZR4Cs6/fRU5T5jcU1w6cZ+3cMOXIfembkRDpbUlvmNTvWyIZaVHQGkejDfbcnl
         VxM82pg56VqB5RMtMBAsrqJxgRcU9ryBs37Ds6TeG6MQn2y2KLSDP75wulCk+Dha7Ekb
         sfAvgl3H68EdOTQJ+G6NF2wuOTaVahuV4YCA7xlqaZzl+wb8svBt6qI26mq+Wh7Xo4EI
         GT7w==
X-Gm-Message-State: AOJu0YwbzN3V/pkuhE6Z9eBWOYKFOFKs/9PFfGYsBcNrgHm+zPy1KCHh
        Eb2fw+ys/Y8FXdvgG1JCY1SCkfWBhbvCaWjErKrgliTScNzevRY85etJTt9IN+FZKz3OvHMJxWk
        UxSgISbAJGJpLG0CeLg==
X-Received: by 2002:a05:6a00:2354:b0:68a:6e79:d23b with SMTP id j20-20020a056a00235400b0068a6e79d23bmr11702246pfj.23.1692972015379;
        Fri, 25 Aug 2023 07:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLebA4sWSvMf5za4+Qucu3UOW/hpn/TicURPd7Beo5zSzX+vfX2PvKu1KYi02yGz+VTymeA==
X-Received: by 2002:a05:6a00:2354:b0:68a:6e79:d23b with SMTP id j20-20020a056a00235400b0068a6e79d23bmr11702035pfj.23.1692972013250;
        Fri, 25 Aug 2023 07:00:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00686a80f431dsm1561864pfa.126.2023.08.25.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:00:12 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:00:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] common/rc: introduce _random_file() helper
Message-ID: <20230825140009.4pg43yyprmunrxkn@zlang-mailbox>
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
 <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825133948.oubggt74y7cmci2j@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 25, 2023 at 09:39:48PM +0800, Zorro Lang wrote:
> On Mon, Aug 21, 2023 at 04:12:11PM +0900, Naohiro Aota wrote:
> > Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
> > random file in a directory.It sorts the files with "ls", sort it randomly
> > and pick the first line, which wastes the "ls" sort.
> > 
> > Also, using "sort -R | head -n1" is inefficient. For example, in a
> > directory with 1000000 files, it takes more than 15 seconds to pick a file.
> > 
> >   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
> >   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total
> > 
> >   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
> >   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total
> > 
> > So, we should just use "ls -U" and "shuf -n 1" to choose a random file.
> > Introduce _random_file() helper to do it properly.
> > 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/rc | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 5c4429ed0425..4d414955f6d9 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5224,6 +5224,13 @@ _soak_loop_running() {
> >  	return 0
> >  }
> >  
> > +# Return a random file in a directory. A directory is *not* followed
> > +# recursively.
> > +_random_file() {
> > +	local basedir=$1
> > +	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
> 
> I think the "1" can be the second argument, for we might want to get a random
> file list sometimes. For example:
> 
>   local basedir=$1
>   local num=$2
>   local opt
> 
>   if [ -n "$num" ];then
> 	  opt="-n $num"
>   fi
>   echo "$basedir/$(ls -U $basedir | shuf $opt)"
> 
> What do you think?

Hmm... nack my review point. Looks like this makes a simple change to be
complicated, especially multiple output lines. I'll merge this patchset
at first, then we can support that second argument If we need that
feature in one day. Or if you're interested in it.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > +}
> > +
> >  init_rc
> >  
> >  ################################################################################
> > -- 
> > 2.41.0
> > 

