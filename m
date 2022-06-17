Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E7C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jun 2022 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383159AbiFQRwW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiFQRwV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jun 2022 13:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A8624D6A4
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655488340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OtgWOciqyrg03MkJpIxP3UFTyHzwB/PbXkc9oHvQYQ=;
        b=VeZA/4D2OhM/EGX5QMB6HEXEAYJje8U/nyevO6Grp1qWFw6uMTq90ZPAmHniPsifueO5y1
        ESRGRI2a0f0x4APiC3TbnGQ8MC6ZoBR1HR+O/M/qmf4CW7mWe/pTXrFdfozlCBE6wboDTs
        hd7Oys46HILbOuw3oRwszU+5GsTPeV0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-046miNV5Nm2noEYT8z7vEQ-1; Fri, 17 Jun 2022 13:52:18 -0400
X-MC-Unique: 046miNV5Nm2noEYT8z7vEQ-1
Received: by mail-qk1-f198.google.com with SMTP id k13-20020a05620a414d00b006a6e4dc1dfcso5660342qko.19
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 10:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2OtgWOciqyrg03MkJpIxP3UFTyHzwB/PbXkc9oHvQYQ=;
        b=ks+tAft4/0w3k5NHpPMsxiWPYdB2eYMPFpQ5VyJ2Qr5DAptyYE7XNCzlLlEho+2oXk
         KRSWvrkKpT6xaCtHHuOc3vZGfwbogMX6dPBkh56wk2HURhUb+iP6zGbxfg30kn6KxbwD
         EE0vlCNUJVJG5hPEZ4Oz/S/ZKWLWuzOkP6aOWZa35nU8ftBeVtQ6bLqfeGcbo2I3/RWq
         qL8s9TY6QvxorOyvrkaHaH7LRnAICZhIe4fPskBmz28rwXVpX3MKHgOYtmr/bFJ0Txq+
         bDk/QaFc1IrFPlF77ydJyPSqLftSG9a0h4p9d1Ct0b97C+/aWSMUd82wIGCD+ogiCZST
         QeiA==
X-Gm-Message-State: AJIora96uYgK6TnlQyx3h2vnZvKpg3GAykoxEmjQro4GZVtHPFC09IFv
        r4B9QLcF11VWFk24BFMFllDWslsC2EI7qd5eMnxKxCCDQ9qbDOzgBINn15aEuwhKqTx0g9Rt3mI
        LF5zPdyAtiMZLZkvdcyPpwV6LXJuYaXhoGcloPJldUWPN13esLVHsgS7G1UN9x/MNOA==
X-Received: by 2002:ad4:5c66:0:b0:464:6b58:e695 with SMTP id i6-20020ad45c66000000b004646b58e695mr9361795qvh.126.1655488338081;
        Fri, 17 Jun 2022 10:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJFBvgRfBe2yRm8kGfp7L4ALeTF2wWFsdIhX1RJ0hiMPb+BM2Xe5SAzU9Be7OOTiKkf/O3OQ==
X-Received: by 2002:ad4:5c66:0:b0:464:6b58:e695 with SMTP id i6-20020ad45c66000000b004646b58e695mr9361769qvh.126.1655488337738;
        Fri, 17 Jun 2022 10:52:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006a32bf19502sm4895612qkb.60.2022.06.17.10.52.15
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 10:52:17 -0700 (PDT)
Date:   Sat, 18 Jun 2022 01:52:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Message-ID: <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
References: <20220616043845.14320-1-lan@suse.com>
 <20220617035836.GZ1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617035836.GZ1098723@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 17, 2022 at 01:58:36PM +1000, Dave Chinner wrote:
> On Thu, Jun 16, 2022 at 12:38:43PM +0800, An Long wrote:
> > Function _scratch_mkfs_sized cannot recognize the size descriptor.
> > 
> > For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
> > ext4, will fail with "mkfs.ext4: invalid block size - 4".
> 
> So isn't the correct fix for this to use the correct format in
> MKFS_OPTIONS? ie. "-b 4096"?
> 
> i.e. why do we need ito add code to fix something that the user must
> specify themselves and could easily just use an integer to begin
> with?

The fstests doesn't notice users that they *must* use pure number in
MKFS_OPTIONS, especially the block size.
As this issue, we have to accept the size unit(k/m/g ...) or have to
tell the users that they must use pure integer, any of "k/m/g" is
unacceptable. I prefer the former, so I'd like to have this change,
except anyone has a better idea :)

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

