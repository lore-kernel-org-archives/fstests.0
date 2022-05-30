Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469CBC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 30 May 2022 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiE3Fne (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 May 2022 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiE3Fnc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 May 2022 01:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E67D5B3DB
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653889410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZ/4mlWjepwLRahdAGwoRcNx8P0u6BVOKelxdWtuCHE=;
        b=QOxhVowzglfL9cMD0wxpwbtRvVu3OEu2KKvbrA5Ys9oiM+3VkeqKemtxs8wlPCxWb0boQw
        6JCKo1eGs5KsFRAo9u8ePSiqYATWm/7FVQB3Cu2/1+eHaWR3/6mEaw1T4iE/WDkdMo6u9b
        UNyu8qSSHYksjVqtrN644m/OBVQxkNI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-j-j9UxgxPE-IKq9pMGbE-A-1; Mon, 30 May 2022 01:43:26 -0400
X-MC-Unique: j-j9UxgxPE-IKq9pMGbE-A-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-f32f6522c6so1758497fac.18
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 22:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZ/4mlWjepwLRahdAGwoRcNx8P0u6BVOKelxdWtuCHE=;
        b=ZiuWiXNpIup9jPcQgyisIT2u+yh130tRINFtYjOF9zjsZZajg+HLTkis/7EiyhNQnh
         nSHsib+5ofxaOCVjrFMFsBdC6d75IoeAZ4Nye9rkkezvRcefVcS94VEkbF2zLSW2MFBJ
         0+h9N0VIBLgCCeTAdFxSzvFBj0Z8kdydzCtGOd0nO6dzGqLTYOETbmhArJvO6WA5bIWv
         vedEp50SnfYkkgrUS3w/ZiDvOddvI0tIECVF0sBdx4nM3AThxv9PL+bFHx80v2Ztz028
         fJ3vWDD/IXif2enn+w32cWYK248GUXZpJ11Bo2DztM1GAWm0tWUYMIpaJw4xG4Qo83CQ
         Ofjw==
X-Gm-Message-State: AOAM533mEd1lZn6xde70QTc+B7Z6R5Mz6caOfNJV55sTGdc6q39ZkgFw
        Llbste5fPR7P4wCDYuLBYzdHkhNYZPkaNHVF9Cu+ot9IWZQZ8r8KBdiQ/ORBzI9kvSEQceQnggl
        egH3HNfXcPXtGjm9w6w==
X-Received: by 2002:a9d:1b68:0:b0:606:ae01:ce2e with SMTP id l95-20020a9d1b68000000b00606ae01ce2emr20811681otl.121.1653889405931;
        Sun, 29 May 2022 22:43:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvr+m+qb2aLHZcny5NqhPB3rRXV3lWbjr7JTqut1hnGwj3QUgrbYaJLKnhrPoHTusGBrRH7A==
X-Received: by 2002:a9d:1b68:0:b0:606:ae01:ce2e with SMTP id l95-20020a9d1b68000000b00606ae01ce2emr20811678otl.121.1653889405671;
        Sun, 29 May 2022 22:43:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r36-20020a05683044a400b0060ae5f10973sm4608430otv.15.2022.05.29.22.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 22:43:25 -0700 (PDT)
Date:   Mon, 30 May 2022 13:43:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] generic/591: remove redundant output from golden
 image
Message-ID: <20220530054320.e2ujzgmygp2uoqid@zlang-mailbox>
References: <20220529105505.667891-1-zlang@kernel.org>
 <20220529105505.667891-4-zlang@kernel.org>
 <20220530004452.GN3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530004452.GN3923443@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 30, 2022 at 10:44:52AM +1000, Dave Chinner wrote:
> On Sun, May 29, 2022 at 06:55:03PM +0800, Zorro Lang wrote:
> > In generic/591.out expects below output:
> >   concurrent reader with O_DIRECT
> >   concurrent reader with O_DIRECT     <=== ???
> >   concurrent reader without O_DIRECT
> >   concurrent reader without O_DIRECT  <=== ???
> >   sequential reader with O_DIRECT
> >   sequential reader without O_DIRECT
> > 
> > The lines marked "???" are unbelievable, due to the src/splice-test.c
> > only calls printf to output that message once in main function. So
> > Why splice-test prints that message twice sometimes? It seems related
> > with the "-r" option, due to the test lines without "-r" option only
> > print one line each time running.
> >
> > A stanger thing is this "double output" issue only can be triggered by
> > running g/591, can't reproduce it by running splice-test manually.
> 
> Huh. I wonder....
> 
> > diff --git a/src/splice-test.c b/src/splice-test.c
> > index 2f1ba2ba..e6ae6fca 100644
> > --- a/src/splice-test.c
> > +++ b/src/splice-test.c
> > @@ -143,6 +143,7 @@ int main(int argc, char *argv[])
> >  	printf("%s reader %s O_DIRECT\n",
> >  		   do_splice == do_splice1 ? "sequential" : "concurrent",
> >  		   (open_flags & O_DIRECT) ? "with" : "without");
> > +	fflush(stdout);
> 
> Yeah, ok, stdout output is usually line buffered.  That printf()
> statement has a "\n" on the end of it, so it should be flushing
> immediately, and that's what you are seeing when it is run from the
> command line.
> 
> Hmmmm. I wonder if the redirect to an output file (or pipe) is
> changing the buffering mode because stdout no longer points to a
> tty?
> 
> # src/xfstests-dev/src/splice-test -r /mnt/test/a
> concurrent reader with O_DIRECT
> # src/xfstests-dev/src/splice-test -r /mnt/test/a | less
> concurrent reader with O_DIRECT
> concurrent reader with O_DIRECT
> #
> 
> Yup.
> 
> # man setbuf
> ....
> 	Normally all files are block buffered.  If a stream refers
> 	to a terminal (as stdout normally does), it is line
> 	buffered.   The standard  error  stream stderr is always
> 	unbuffered by default.
> 
> Yeah, so the stdout redirection that fstests does is exactly what is
> changing the behaviour.
> 
> Ok, so the correct way to fix this is to add:
> 
> 	setlinebuf(stdout);
> 
> before any printf() output to ensure that it is correctly line
> buffered no matter what the output redirection does with stdout.

Wow, that's it! You reveal the root cause of this issue :)

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

