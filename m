Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE2C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 13:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiDYNV0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiDYNVX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 09:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E4EA1903D
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650892697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XS6gOTbkQf02kUMbhirWJGdTGuW1tNFxgL4mvJteJtw=;
        b=axqd1NPJMaaa/8ztp4qfkX81xxDxr1gA4s/OTYjrZ4j2cGaiMg3JQJWr6yo1VFZir+6TJx
        FlRrzFJxx5kiuq8PNV0X1I8bEhlYFvAWwM7Hp1fz7pfeEmPCl4Nk6hyRv5vnzaFIUahfit
        pNs4u3CH6kIwz9i6dtgfgaD70/8cz/0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-XkXy9d3LPNKswqbMpL-nDw-1; Mon, 25 Apr 2022 09:18:16 -0400
X-MC-Unique: XkXy9d3LPNKswqbMpL-nDw-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso9645250qkb.11
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XS6gOTbkQf02kUMbhirWJGdTGuW1tNFxgL4mvJteJtw=;
        b=X0+h4TuP9GZUzt/12sdDF9lcYy8ioQ8kmTwlmTaaJiSrtI+fxbpHM2DrIEY9IceuW0
         j5LiKhFId2jDfiDvIHuVXZ9kQdUdjecGn3LoAWqASVKyOS7BToqC+2tDWQGW0ZLm6AXU
         /A5GPzRibXG33x/fv1G9fy6NvX1RiUVE8dIVxg/tYTgVYZZZ8EGQg9orc+Gu9FQgcYiQ
         SaeWu75h+tukBE+asJ0JYV+eAWQNjzIsW8qITp0taX5WM/bMngFYXDj1MaWfhUOP1Cb/
         rXQAxh8+FVRzFMI0YZMeeqNwxUaDKR0PaenhuVewWYKHiLGpBcC1qD9Be6hj8Y5uNhsy
         gJCg==
X-Gm-Message-State: AOAM532dbxSauwqN/voFwZn5+eB83VxJtKBLH88cgaFDmcfoi6i5Nth4
        Ws3N0ZjDW/oorPrZOc4ekqZdbRZBESqLHKZvO4h/DiUiOvae99lxELDFdcA801VQm6y8SNbhHaW
        oUhdcp+fia7BP9mYHSQ==
X-Received: by 2002:ac8:5851:0:b0:2e1:eba3:3beb with SMTP id h17-20020ac85851000000b002e1eba33bebmr11720520qth.20.1650892695769;
        Mon, 25 Apr 2022 06:18:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwghaGBfrRmKH2Vg47SwQxQnIkWCLeJK4WX75liK7JyB5Et+rfaaA0v8z5s7ENPSXTknwQttA==
X-Received: by 2002:ac8:5851:0:b0:2e1:eba3:3beb with SMTP id h17-20020ac85851000000b002e1eba33bebmr11720498qth.20.1650892695502;
        Mon, 25 Apr 2022 06:18:15 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a099700b0069e5cd89332sm4866809qkx.77.2022.04.25.06.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:18:15 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:18:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix generic/633 failure on systems without
 CONFIG_USER_NS
Message-ID: <20220425131809.qzjrah7cw67mzzcw@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
References: <20220331111920.8377-1-jack@suse.cz>
 <20220331113912.uzaojcp3ih5uibmr@wittgenstein>
 <20220420175911.ei7l4xb6mee3a2cn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420175911.ei7l4xb6mee3a2cn@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 20, 2022 at 07:59:11PM +0200, Christian Brauner wrote:
> On Thu, Mar 31, 2022 at 01:39:12PM +0200, Christian Brauner wrote:
> > On Thu, Mar 31, 2022 at 01:19:18PM +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > these two patches fix a failure of test generic/633 on a system without
> > > CONFIG_USER_NS.
> > 
> > Thank you!
> > I've pulled and tested the patches.
> > RVB+TB on the individual patches.
> 
> Hey Eryu,
> hey Zorro,
> 
> Jan's patches have not shown up in xfstests upstream and I think they
> got lost on the mailing list.
> 
> Hopefully they can be picked up this week.

Hi Christian,

This patchset has been merged in my local branch now, I'll give it (and other
on-queue commits) a testing this week, then push them this weekend if test
pass.

Thanks,
Zorro

> 
> Thanks!
> Christian
> 

