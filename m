Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F3C64EC4
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCHR2y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHR2w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 12:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8A1F481
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678296483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nee6K4yqig2KQ8Wy/WRlyQ7cGC7q+f73VxS0Vnj5tn4=;
        b=U41skf7OtVpWZtlCEZOotR/j16siy02PWKWDKDSRDpP8GX074xERtekM/cNm8VJGQboeok
        z7iyQIHm5o3ebIeN6soEf9psAMH4SRt9wCeLzUcDibaURsidQbKXYIzRoyuxTxwYdowGSk
        np2L3BCQJZRcL4jq79gWyvOFZ3NBB3E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-PabOF70nPuenoti4LFwteg-1; Wed, 08 Mar 2023 12:27:54 -0500
X-MC-Unique: PabOF70nPuenoti4LFwteg-1
Received: by mail-pj1-f72.google.com with SMTP id fa21-20020a17090af0d500b00237b14b60a4so1126667pjb.6
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2023 09:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nee6K4yqig2KQ8Wy/WRlyQ7cGC7q+f73VxS0Vnj5tn4=;
        b=xvxJZfA3Gzzgyv8NaP2sg2KXH3um24CKyN5HPteMp0+emtFkhD79eMSC0y1WEp9RoT
         dUD5FwE3plClX2owsDC6VaFSGhCGlxbd5Ibiv4qSXT9mDBfjaDgzdL6dztMWimABiQvO
         rc3SsNbTK0UqXGZo50/lMiV32QgsCxWsEgjdKzKhf7djYw4ZWV/EKQzQeqKfdKqCoIr+
         xr0TGs5/rPnOqO4kEuHY/VAdwe1g3GEwtAm0MDwtpu1Im9bAwDnsox8D2CvGhHmnvCi4
         1hNdGWLWRroPjBGjFJdcjrvtNR3anVkY6SGQl02fHsHHRbQpAMj85D5KQL2g1ZrlFUYt
         O6EA==
X-Gm-Message-State: AO0yUKUdi57Suir/1Kg7SvljYGoxU1IyFw/6bkHJK5scsNoy+AfhtEDN
        WkhcHVPYECkv1YbvioQixBO9OIWuJUZymiuBB7uZ6nICh2oE67M+YIaJ9QwK8UMZ6VkUQKQv4li
        hfunXLB5/Xg/ARpPaqA==
X-Received: by 2002:a17:903:22ca:b0:19e:685f:484a with SMTP id y10-20020a17090322ca00b0019e685f484amr23541072plg.62.1678296473077;
        Wed, 08 Mar 2023 09:27:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8/pMwJSwz/ZRt8rw7+pqrCjOCMp8vW7rrN54hEdL8W7N45clWeWzTCN7hIweHpM/R8jLljpw==
X-Received: by 2002:a17:903:22ca:b0:19e:685f:484a with SMTP id y10-20020a17090322ca00b0019e685f484amr23541050plg.62.1678296472685;
        Wed, 08 Mar 2023 09:27:52 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kk6-20020a170903070600b00194c1281ca9sm10132878plb.166.2023.03.08.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:27:52 -0800 (PST)
Date:   Thu, 9 Mar 2023 01:27:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Rodrigo Campos <rodrigo@sdfg.com.ar>, fstests@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 11/11] vfs: Use tabs to indent, not spaces
Message-ID: <20230308172748.rmsmcnaw7xxmfeoi@zlang-mailbox>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-12-rodrigo@sdfg.com.ar>
 <20230307165508.77ptsmv2zdotw6xg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165508.77ptsmv2zdotw6xg@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 05:55:08PM +0100, Christian Brauner wrote:
> On Tue, Mar 07, 2023 at 12:45:07PM +0100, Rodrigo Campos wrote:
> > Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> > ---
> 
> I think I explicitly used spaces but I don't know why anymore tbh. So
> I'll live that to Zorro whether he wants to take this patch or not. I
> have no strong opinion. :)

Thanks Christian, I prefer 8 character tabs generally, I recommend that
but it's not mandatory.

If I have to say a restriction, "please use/keep using same indentation
format in a same sub-case or sub-project (e.g. src/vfs/*, ltp/fsstress.c)"

Anyway, I don't think we need to use a single patch to change code indentation
only (except it's a big mess:). Better to pay attention to it in regular case
writting and reviewing.

Thanks,
Zorro

> 
> >  src/vfs/vfstest.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git src/vfs/vfstest.c src/vfs/vfstest.c
> > index 3d75b1e3..dea344cc 100644
> > --- src/vfs/vfstest.c
> > +++ src/vfs/vfstest.c
> > @@ -107,7 +107,7 @@ static int hardlink_crossing_mounts(const struct vfstest_info *info)
> >  	int fret = -1;
> >  	int file1_fd = -EBADF, open_tree_fd = -EBADF;
> >  
> > -        if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
> > +	if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
> >  		log_stderr("failure: chown_r");
> >  		goto out;
> >  	}
> > @@ -2307,22 +2307,22 @@ static void usage(void)
> >  	fprintf(stderr, "    Run idmapped mount tests\n\n");
> >  
> >  	fprintf(stderr, "Arguments:\n");
> > -	fprintf(stderr, "--device                            Device used in the tests\n");
> > -	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
> > -	fprintf(stderr, "--help                              Print help\n");
> > -	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
> > -	fprintf(stderr, "--idmapped-mounts-supported         Test whether idmapped mounts are supported on this filesystem\n");
> > -	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
> > -	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
> > -	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
> > -	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
> > -	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
> > -	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
> > -	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
> > +	fprintf(stderr, "--device			     Device used in the tests\n");
> > +	fprintf(stderr, "--fstype			     Filesystem type used in the tests\n");
> > +	fprintf(stderr, "--help				     Print help\n");
> > +	fprintf(stderr, "--mountpoint			     Mountpoint of device\n");
> > +	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
> > +	fprintf(stderr, "--scratch-mountpoint		     Mountpoint of scratch device used in the tests\n");
> > +	fprintf(stderr, "--scratch-device		     Scratch device used in the tests\n");
> > +	fprintf(stderr, "--test-core			     Run core idmapped mount testsuite\n");
> > +	fprintf(stderr, "--test-fscaps-regression	     Run fscap regression tests\n");
> > +	fprintf(stderr, "--test-nested-userns		     Run nested userns idmapped mount testsuite\n");
> > +	fprintf(stderr, "--test-btrfs			     Run btrfs specific idmapped mount testsuite\n");
> > +	fprintf(stderr, "--test-tmpfs			     Run tmpfs specific idmapped mount testsuite\n");
> >  	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
> >  	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
> > -	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
> > -	fprintf(stderr, "--test-setgid-create-acl            Run setgid with acl tests\n");
> > +	fprintf(stderr, "--test-setgid-create-umask	     Run setgid with umask tests\n");
> > +	fprintf(stderr, "--test-setgid-create-acl	     Run setgid with acl tests\n");
> >  
> >  	_exit(EXIT_SUCCESS);
> >  }
> > -- 
> > 2.39.2
> > 
> 

