Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48076C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 01:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiF3Bj4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF3Bjz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 21:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46AA92A70C
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656553193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RYwON/A7BRvKzCn6ouOH2npqdnWbzvQPIiTO/aam6e4=;
        b=DzUgTu0J8Sz637mDQIO2PnSWyO1hEkHUYXXwPINZ86HR5SYzwZHfrilw4O7270YO66ztpV
        VaRkfVarOiiDF6RpZ+pPZ5euunM80b0DwboTuZHfQWWdvzVW6q3MXMQTZ+3oN6GQQtcfag
        M7RPeY3g6EMWPsOGd7SNpc+EZDpYhIs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-GVt35vrUOoiutRDm7hFnqg-1; Wed, 29 Jun 2022 21:39:51 -0400
X-MC-Unique: GVt35vrUOoiutRDm7hFnqg-1
Received: by mail-qv1-f69.google.com with SMTP id ls8-20020a0562145f8800b0047078180732so16940653qvb.2
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 18:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYwON/A7BRvKzCn6ouOH2npqdnWbzvQPIiTO/aam6e4=;
        b=26IXGX2GDZPwOEiQic0ZTYuwiVIc6bY+xLnh00SHG45/sglepFBHbFyaoRBc+5Ueb0
         DkR06FDXUyXL5140k9UGI/rdOXn6N7Ki9r1N86WvC+rTvOuUB9OocMajgbxuwnCGu6yD
         SKGIBkV2Jl7+s7Gu4L7n1agKxqjkUo0MOUpy1M7lU1/aP1cbU+/3gwBvuW7+Ud1YhosI
         yI6gBt9yiCM31X07NtcBMDPK87eIfYy5ESAsza+ozY2vwufBeXcDOV7W4u89EgLh5DKG
         N1PBg9HxrAsxvsAaq0T4qJw/U/f/UaDehHQ5ztQy5grTo+DimLi/MiiEZUrQ8ksubNZ7
         defw==
X-Gm-Message-State: AJIora/xJyu9ec941A5bJoS8k1EwG502/ShqBaajK9+3VJ91pWi2V1FW
        UoFERHiWrxUfHP8ZMAiV1sFonqCpgC7gewFZoB+/Kc6SlKpDLRejIBM5oQtPd4lKCHewXspKvwH
        9pQnF15ugJQ2tebewFA==
X-Received: by 2002:a05:622a:1116:b0:31d:282a:f0b8 with SMTP id e22-20020a05622a111600b0031d282af0b8mr4191753qty.453.1656553190958;
        Wed, 29 Jun 2022 18:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uJPM7cBIvvC8fiNsQlFxjIU779EGHExUJh4K5flqR1KNqqGnMw89e9C+HuFYbyYRMBxqFl5A==
X-Received: by 2002:a05:622a:1116:b0:31d:282a:f0b8 with SMTP id e22-20020a05622a111600b0031d282af0b8mr4191736qty.453.1656553190632;
        Wed, 29 Jun 2022 18:39:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ci27-20020a05622a261b00b00316dc1ffbb9sm4568240qtb.32.2022.06.29.18.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 18:39:50 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:39:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 7/7] ext4: create file systems with the encrypt
 feature as necessary
Message-ID: <20220630013945.vzndbloouk5rknwc@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-8-tytso@mit.edu>
 <20220629133052.3knyrselanytvrws@zlang-mailbox>
 <YryoPGksgK3UfKvO@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YryoPGksgK3UfKvO@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 03:30:04PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 29, 2022 at 09:30:52PM +0800, Zorro Lang wrote:
> > 
> > As Eric gave some review points to V2, so double check with Eric, if it's good
> > to him?
> 
> Eric, any other issues than the ones which you had mentioned (and
> which I have addressed)?
> 
> Zorro, I have the patches based against for-next, and with your
> reviewed-by tags appended, and tagged with a signed tag on the
> for-upstream branch up on github.  Or if you like I can resend patch
> series via e-mail.
> 
>       	    	       	   	- Ted
> 
> The following changes since commit 34c1208f601b5f22c62d0f3ed6f6c55c88aa4eff:
> 
>   xfs/{422,517}: kill background jobs on test termination (2022-06-25 00:27:11 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/tytso/xfstests tags/for-zorro
> 
> for you to fetch changes up to 43dec26fe614b1d8ad8f4c67aaf6f88413b7f2f8:
> 
>   ext4: create file systems with the encrypt feature as necessary (2022-06-29 15:11:41 -0400)

Hi Ted,

Sure, if you won't change anymore, I'll get this patchset by:
  $ b4 am $message_id_of_this_email

If you still need to do more change, I can fetch the final version from above
git repo you metioned. Feel free to tell me, if it's ready to be merged :)

Thanks,
Zorro


> 
> ----------------------------------------------------------------
> Miscellaneous ext4 test fix ups
> 
> Previous versions of this patch series can be found at:
> 
>  - v1: https://lore.kernel.org/r/20220625030718.1215980-1-tytso@mit.edu
>  - v2: https://lore.kernel.org/r/20220628182545.1834145-1-tytso@mit.edu
>  - v3: https://lore.kernel.org/r/20220629124540.175775-1-tytso@mit.edu
> 
> ----------------------------------------------------------------
> Theodore Ts'o (7):
>       ext4/050: support indirect as well as extent mapped journals
>       ext4/044: skip test if the file system does not have a journal
>       ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
>       ext4/054: skip test if the dax mount option is enabled
>       ext4/055: skip test if dax mount option is used
>       ext4/035: skip this test if the scratch device does not support 1k block sizes
>       ext4: create file systems with the encrypt feature as necessary
> 
>  common/rc         |  3 +++
>  tests/ext4/003    |  6 +++++-
>  tests/ext4/035    |  8 +++++++-
>  tests/ext4/044    |  1 +
>  tests/ext4/045    |  2 +-
>  tests/ext4/050    | 58 +++++-----------------------------------------------------
>  tests/ext4/054    |  5 ++---
>  tests/ext4/055    |  1 +
>  tests/ext4/306    |  3 +++
>  tests/generic/260 |  5 ++++-
>  10 files changed, 32 insertions(+), 60 deletions(-)
> 

