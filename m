Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63149C001DE
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Jul 2023 19:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjG1TxK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Jul 2023 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjG1TxH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jul 2023 15:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17F3C07
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2023 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690573943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOq9JB2HyxJb7lVESi8+HzQSueG1TwWso5ZIWy53uRc=;
        b=GXsQcTV9uutW0Gr5G3i3Wvsz8nvzT11T16ikG2q+NnF36WnSsKk8h5hMC8Vd9k0K87P/m0
        1L7+yPrezWcvO45C6ATejnPJz3DXT6bLfungtW8caTgFRooqIQhOzHO8mIuZNLjbjSl1M2
        fjwe+D+rnTDHMZ0ZqJgzxSgsxXkPE6Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-fJ76rEvIM8Cp_01plnwz1g-1; Fri, 28 Jul 2023 15:52:21 -0400
X-MC-Unique: fJ76rEvIM8Cp_01plnwz1g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bbf8cb6250so749455ad.2
        for <fstests@vger.kernel.org>; Fri, 28 Jul 2023 12:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573940; x=1691178740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOq9JB2HyxJb7lVESi8+HzQSueG1TwWso5ZIWy53uRc=;
        b=koWRKwRnvrsBun5XRLFBCU9rqb2vq1l9tqqTPvcns7KYGkHWimCYAp8+Rtlg71uoIc
         xYVMgjBJjKiYokkBznQTnNBZBVp4b1LTyxFGGDWKGQX68MVOxVg+3XBZ0JPSUsBD6irX
         t1R6zHycgi5+9t2otLEM6xqC4x6+JKs1LuAW4Rdk+hE46s8b6IaaA2haloeQrje9uMeT
         Wz2vw7DnYujS6eZ5gLh1qgW/ylhmnQFtbVL0AaAjfEQIvOVVZ6mB+lbXtEMZ+T5baI2D
         dDyCza1/tUH82Me1fNh7ueUgfz4nkUaZA7bzc0opTmPDu842M4wiEmWrQdA/GpqyBJSv
         jbIA==
X-Gm-Message-State: ABy/qLbIVQnpqoKoXXQP+0jg1mFgHLcezrgwLI6w9t26pMoK/wLA5a5Y
        brHhb8o5IAbHiKThkGh964HpwPYPQHVrvRVOkhq7U3kfQW5tU3Ikq7nm+SxY5MhYg+WWGOQCThG
        pBDors3uqfQFKBtwWMCNfnGzPMbVo
X-Received: by 2002:a17:902:bc87:b0:1b3:f5c3:7682 with SMTP id bb7-20020a170902bc8700b001b3f5c37682mr2183946plb.68.1690573940397;
        Fri, 28 Jul 2023 12:52:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCDVa18bBrW4u2ors82jL8p8uD5nBqNHCcjpALWW5yggmyp1R1Ke5HWAlSwSZrsBMoRoypAg==
X-Received: by 2002:a17:902:bc87:b0:1b3:f5c3:7682 with SMTP id bb7-20020a170902bc8700b001b3f5c37682mr2183932plb.68.1690573940128;
        Fri, 28 Jul 2023 12:52:20 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001ac95be5081sm3941482ple.307.2023.07.28.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:52:19 -0700 (PDT)
Date:   Sat, 29 Jul 2023 03:52:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] check: add a -smoketest option
Message-ID: <20230728195216.yfsnv56nr266gh7l@zlang-mailbox>
References: <20230720022756.GH11352@frogsfrogsfrogs>
 <20230720143433.n5gkhukdkz7s5ab7@zlang-mailbox>
 <20230726000524.GG11340@frogsfrogsfrogs>
 <20230726060102.GB30264@mit.edu>
 <20230726145441.lbzzokwigrztimyq@zlang-mailbox>
 <20230726205930.GC30264@mit.edu>
 <20230727032537.hyqyuvemnwmh25d5@zlang-mailbox>
 <20230727143326.GG30264@mit.edu>
 <20230727153046.dl4palugnyidxoe7@zlang-mailbox>
 <20230728155307.GB606216@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728155307.GB606216@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 28, 2023 at 11:53:07AM -0400, Theodore Ts'o wrote:
> On Thu, Jul 27, 2023 at 11:30:46PM +0800, Zorro Lang wrote:
> > 
> > Yeah, I'd like to tidy the ./check, include the option names. But change the
> > check option format will affect many users, cause most of their scripts go
> > wrong suddently, then they need to check and use new option format. That's
> > why I still not touch this part.
> 
> What if we add support for the double-hyphen variant for those options
> that use a syingle-hyphen, and then wait say, a year or so, and then
> add a deprecation warning to the single hyphen options, and then a
> year latter drop support the single-hypen variant?
> 
> I can send a patch for the first part of the process if you think that
> makes sense....

Sure, that makes sense to me. Let's take the first step, we'll see the
influence :)

And I'd like to use bash buildin getopts() or other standard ways to deal with
./check options, when we can replace those single-hyphen options totally. If
you have any better idea, feel free to share with me :)

BTW, several month ago I tried to check with you that:

  https://lore.kernel.org/fstests/20230207182656.ekjt2lhbid6xf2cs@zlang-mailbox/

Any thoughts?

Thanks,
Zorro

> 
>       	     	       	    	   - Ted
> 

