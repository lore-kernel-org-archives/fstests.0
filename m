Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33BBC433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 08:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359440AbiEGIo5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346493AbiEGIo4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 04:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF4DB3EF31
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651912869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZ3kB1TcC+mbL3tah86SEbbLQ32LfSzPW0nX/p3YLcU=;
        b=TaUpXC5YSe/NIHx1MvXubXKpGUV8uCHmv3BbAjfNcYovdZrbFqbLGZ/yz4qu739h4urUBu
        yZ0jA3fHucdrQey906NOW8tiKJjHqbTQh0HxceoiMqSroWOg9oRAx8+puTKI9qqkBo/EsO
        Ha/EthtA7b+2EkA+AGuXXks2jzxr/98=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-4VuVLan0M76-yRgOGpjGlw-1; Sat, 07 May 2022 04:41:07 -0400
X-MC-Unique: 4VuVLan0M76-yRgOGpjGlw-1
Received: by mail-qv1-f72.google.com with SMTP id e3-20020a056214110300b0045abb0e1760so7315802qvs.3
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 01:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RZ3kB1TcC+mbL3tah86SEbbLQ32LfSzPW0nX/p3YLcU=;
        b=TVChDRyMqAlZINoNA7zPwqZMx+Y05HYUQNrubfFCDy+RsVXQ1x/0zBPaeCbqwdSByt
         xTy4CcTqpTOzF0lyu1K78CO02G0tJloXCHby0sY5QwgOflWPWR9wmn/XCfKM4o/S2tao
         UJbIMjSPHkbsZrCojZ9NQ+0JJWPO1BYjJTESp/mzw2PxfKCEvn3/D5yfkypW8OzWMJeZ
         qjX0P6+FMBy0H8YmJID3ykhbrARnYvw+cSkC1EBAZEEmJlfzXYz8Yfo3PYrKt3WYcPhn
         m1tUsgquvN86czz+Duti9nmQFFer8T04Qsgbm5o57nfvKPsUhesiAyxCFBOgYPgQtwvo
         fNSg==
X-Gm-Message-State: AOAM532Wm4FPz/G3C3SV/70gfhTjzKwHA0rULfDxetgIjBb+R5ITqvgw
        uzp94kVjtVUEPfkIwR37UxIvzYxiSJe6DO+uCctqnVp5j0ggTEiFqBw66smrAstbgIjXZUlIBFV
        pJKBAEA1ifyUJdZffhA==
X-Received: by 2002:a05:6214:268d:b0:45a:9606:b8d2 with SMTP id gm13-20020a056214268d00b0045a9606b8d2mr5671016qvb.122.1651912867414;
        Sat, 07 May 2022 01:41:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpkvPb80H8QxGFj2H/JeeHTK2ONtoQ8qegHUvE6UV8KceP2dqgxYw34nC/YVEMp+vHaP7dzA==
X-Received: by 2002:a05:6214:268d:b0:45a:9606:b8d2 with SMTP id gm13-20020a056214268d00b0045a9606b8d2mr5671005qvb.122.1651912867240;
        Sat, 07 May 2022 01:41:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a0d4700b0069fc13ce1easm3644682qkl.27.2022.05.07.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:41:06 -0700 (PDT)
Date:   Sat, 7 May 2022 16:41:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Rishabh Dave <ridave@redhat.com>
Cc:     fstests@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Rishabh Dave <rishabhddave@gmail.com>
Subject: Re: [PATCHv2] cephfs: add ceph-fuse suport for ceph-fuse
Message-ID: <20220507084100.75m2ncu247mbt2wi@zlang-mailbox>
Mail-Followup-To: Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Rishabh Dave <rishabhddave@gmail.com>
References: <20220506150141.333929-1-ridave@redhat.com>
 <20220507072952.dmtr3chfeofthorx@zlang-mailbox>
 <CA+jMu4SNSPtSPyZ+Hv5nC_sJhptj=iM6z4_3C3EZ2FzhTjDOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jMu4SNSPtSPyZ+Hv5nC_sJhptj=iM6z4_3C3EZ2FzhTjDOSg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 01:26:20PM +0530, Rishabh Dave wrote:
> On Sat, 7 May 2022 at 13:00, Zorro Lang <zlang@redhat.com> wrote:
> >
> > This patch has been merged, refer to 1dac95cb ("cephfs: add ceph-fuse suport
> > for ceph-fuse") in fstests for-next branch. And I've helped to fix that ";;"
> > missing problem.
> >
> > The release [ANNOUNCE] is:
> > https://lore.kernel.org/fstests/20220430190921.7BC56C385A7@smtp.kernel.org/
> >
> > If you need to fix more issues, please write new patch base on the latest
> > fstests for-next branch.
> >
> 
> Okay. Thanks for the fix and thanks for the merge.
> 
> Is merging in the for-next branch as good as merging in the master? Or
> should I watch out for my commit until it merges in master?

fstests for-next is an offical branch with PGP signed release version tag,
feel free to prioritize using it. The master branch will be 1~2 weeks later than
for-next, to keep the stability of it. So for-next is fresher, master trys to
be slower and stabler. I explained in last [ANNOUNCE] email [1].

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/20220430190921.7BC56C385A7@smtp.kernel.org/

> 

