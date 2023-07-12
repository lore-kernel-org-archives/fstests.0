Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C11BEB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGLSll (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGLSlk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 14:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DF1BF3
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689187258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATeYOXxzEdFAugRiG3kP8zncxzE0NlT2sHSLVo2/e/o=;
        b=OdWdl5SRdVjVP1fOpolVgWCrF6RVSsjP9vXh3+m3KsnnqIHRvhakVCs3/cXq19Q0ViANsb
        72XtWGt6suKUz7k+Mqc3ANWH99UZScl06ztNuO11Oo+w9f+lYPqjcv0kA0pcGIND39Xrah
        1Z3RFTcszwCLihnOi7P1e7/UmfQ+dgc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-eXatS9dLOB2hvQTtmG9t9w-1; Wed, 12 Jul 2023 14:40:57 -0400
X-MC-Unique: eXatS9dLOB2hvQTtmG9t9w-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c79a5565aso269213a12.3
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 11:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187256; x=1691779256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATeYOXxzEdFAugRiG3kP8zncxzE0NlT2sHSLVo2/e/o=;
        b=XWhF6snOCjkj/iNhdBtGiw0YawcPkC45D+8wIZKmCoJrhWyL83/YO4Yno0jwR9Bch9
         1k5PC0eI3o89MbOAY6YAUek6OAp8fCQjplFYXZSvkRpVYT5u+LI3UZVBrlHieao9AN4C
         uhxJzaij0APXEpNOXRVlv5JpD98p/M/pVLyG9rvSiNiqbzAom/Ca8e+KqHr2bOJuFcvu
         uWeUo1pF2HKt5SOx0odcIaSlT/N7X2wfh7p5ZTujrHAoBerLgd5+k2JGzDfgmQ49xH9i
         ilgrQ3K4rv9CdfhSUDABN3AfLUuasNJZw7GDwzRI0Fjyk5sWFyM/Dva09sycKS5tu+me
         wc3Q==
X-Gm-Message-State: ABy/qLY5fbQhiGlsqFcSFMKKZNBUWrd8Br8F62KyvaisPhQRBTOBTtC4
        P3AdF1jut5WveRwphK2SXkOAJ0XA7stt8naJr0nSUmTbBE7deO+iCpUxBSgui8UM2PclLzonw6l
        IEDGRM+Bj4hLOvpAjnQ==
X-Received: by 2002:a05:6a21:6da3:b0:132:ff57:7def with SMTP id wl35-20020a056a216da300b00132ff577defmr1634677pzb.58.1689187256340;
        Wed, 12 Jul 2023 11:40:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlED7PHJmfRQoClty8p6m5pdtCkbwhj6yymDwoXBSoF22lGnDlsD4xBh3hgFArGgTc7WYxty1w==
X-Received: by 2002:a05:6a21:6da3:b0:132:ff57:7def with SMTP id wl35-20020a056a216da300b00132ff577defmr1634662pzb.58.1689187256037;
        Wed, 12 Jul 2023 11:40:56 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79112000000b00682b15d50a2sm3885617pfh.215.2023.07.12.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:40:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 02:40:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230712184051.6hwpdtuzjkuvcj4f@zlang-mailbox>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> the machine. The reason is that the "while" loop spawns "create_file"
> subprocesses faster than they are able to complete.
> 
> This patch fixes the crash by limiting the number of subprocesses to 128.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  tests/generic/558 |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: xfstests-dev/tests/generic/558
> ===================================================================
> --- xfstests-dev.orig/tests/generic/558
> +++ xfstests-dev/tests/generic/558

The generic/558 was shared/006, it was written for specific fs (e.g. xfs), then
shared with other similar localfs.

After we changed it to a generic test case, the `_scratch_mkfs_sized` helps to
avoid running this case on nfs/cifs and any other fs which can't be mkfs sized.
Originally we thought a fs has a small specific size generally has limited
free inodes. It works for long time, but now bcachefs looks like an exception :)

I think we must limit the number of processes, then let each process create more
files if it need more inodes, that helps to avoid the forkbomb problem, and helps
this case to work with bcachefs and other fs have lots of free inodes in 1G space.

But we'd better to limit the number of free inodes too, we don't want to run this
case too long time. If a fs shows too many free inodes, _notrun "The 1G $FSTYP has
too many free inodes!".

Thanks,
Zorro

> @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
>  while [ $i -lt $loop ]; do
>  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
>  	let i=$i+1
> +	if [ $((i % 128)) = 0 ]; then wait; fi
>  done
>  wait
>  
> 

