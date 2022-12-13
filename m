Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E5C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiLMS01 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 13:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMS0Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 13:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD421116C
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670955938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b99wkxnvBWUJVYaRLF+fWzuX2FLGGpwTMhuD7eJBPPc=;
        b=CnJj444apm5iyJvD3JakUawbMrl9KWyZgU6oFAkE/9uB6xZVwm78cMVfatxZ+y5Cy3hz0u
        ZUsv8SVFKQTPX5xb7cVyyrLW/JGSPP9TrTTIFng3kCl751z0Ce0jbMjKCLIlyacmWMeHTM
        UIM4TzizCli9sy/k92MYnMDj8V66/kQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-PyY3pPPAPBediYciErGb8A-1; Tue, 13 Dec 2022 13:25:37 -0500
X-MC-Unique: PyY3pPPAPBediYciErGb8A-1
Received: by mail-pg1-f198.google.com with SMTP id 69-20020a630148000000b00478118684c4so297539pgb.20
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 10:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b99wkxnvBWUJVYaRLF+fWzuX2FLGGpwTMhuD7eJBPPc=;
        b=zTSfNmj1av8TV+6toqrNkqO6A2Zfe1vJQoB2JA4OeUGqiwZ8KkiXVTzkPGA9pWdUkS
         /HvQhAWlqb+wnuaQSTgZ8NzEikjwS6j1+iFxPAxA9w2yVodocqELeAA2P86QpAmJChWi
         CnucsJY2N0MCXJ8GWAw45DlsrmSEM2u1u/DeHI900/VvFIrySbmNppEg8fHV9JH28GOm
         XxJoqpCSIY5BzgtV6qAGGuc/NJh+kRWN9uPnA2/YidfvU95RJNNSrM0chEu+u7fBm2nd
         tZcElRXqyh8bGLtBu9aMo5plnlHad94uKrckXMgz2AmQA+AwqytfEDqxamU7GRcHytgA
         2Omw==
X-Gm-Message-State: ANoB5pnNmnCjBfrDp4tzvQFAjAYgKY0y/Rm+J9fz50YkYlrWmv9qBI/e
        M3lzNYr3J2STwrfqc5DmgFxHtmEBHB/razJuD+i3QYos7bT3aBK1wn44ZEwbn0xF/SI5hrFExat
        8jQ6EmMtZ5ufu5SLmaw==
X-Received: by 2002:a17:902:6bcc:b0:188:5256:bf60 with SMTP id m12-20020a1709026bcc00b001885256bf60mr21343559plt.25.1670955936077;
        Tue, 13 Dec 2022 10:25:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Ms2FjYHHZOyhJUrm0CPPKSTvWiD2RAWV+AF/MNSuSVqUtz5iYM8QdAmHmykAkiaQKumt9Fw==
X-Received: by 2002:a17:902:6bcc:b0:188:5256:bf60 with SMTP id m12-20020a1709026bcc00b001885256bf60mr21343546plt.25.1670955935790;
        Tue, 13 Dec 2022 10:25:35 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b00188fadb71ecsm234544plj.16.2022.12.13.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:25:35 -0800 (PST)
Date:   Wed, 14 Dec 2022 02:25:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/3] common/attr: require xfs_spaceman for xfs acl_get_max
Message-ID: <20221213182531.3aqgjfzhjoaomy2k@zlang-mailbox>
References: <20221212230820.3466-1-ddiss@suse.de>
 <20221213144152.ae7oqrhtecuqwgya@zlang-mailbox>
 <20221213163234.5ed9cfec@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213163234.5ed9cfec@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 04:32:34PM +0100, David Disseldorp wrote:
> On Tue, 13 Dec 2022 22:41:52 +0800, Zorro Lang wrote:
> 
> > Hmm.. That's weird, both xfs_info and xfs_spaceman are from xfsprogs
> > package. If someone xfsprogs version doesn't hasve provide xfs_spaceman,
> > why its xfs_info would like to call that? What xfsprogs do you use?
> 
> I have a hacky bunch of scripts that use Dracut to generate an
> initramfs image with minimal dependencies for xfstests alongside the
> test kernel: https://github.com/rapido-linux/rapido
> 
> The rapido dependency list is now fixed, but I figured that this change
> makes sense given the other scattered _require_X checks for xfsprogs
> binaries. Feel free to drop this change if you don't agree.

We should let xfsprogs decide how xfs_info works. xfs_info doesn't always
depends on xfs_spaceman, old xfs_info might use xfs_db or other things to
get xfs info, and I don't know if it'll be changed to use other command in
the future again.

So this change will cause all cases which call _require_acl_get_max will notrun
on old (maybe future) xfsprogs which doesn't has xfs_spaceman "info" command.
I think that's not what we want, so I'd like to drop this patch. Thanks for
your understanding.

Thanks,
Zorro

> 
> Cheers, David
> 

