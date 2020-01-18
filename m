Return-Path: <SRS0=dQ9U=3H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E64C33CB1
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D812468F
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Jan 2020 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS/5Xwld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgARJjA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:39:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54332 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgARJjA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Jan 2020 04:39:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so4313088pjb.4
        for <fstests@vger.kernel.org>; Sat, 18 Jan 2020 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fMDz2xpwi7cRAmLy/VBoOICWddnk9d6wR55V0pIhA2M=;
        b=WS/5XwldKOHapc7Gh0rV3mqp4qhc8rXtZZRp2AQqN7OnZkY1IxC6fF0rliDG6WXMPu
         tOU+T9F+QKnnVK37nM0BKIh+yFH2iXZCcQZNbNl5Olna/ATQHGNN7RfWqAcKQNuuMnku
         nPymk2dnvvm+XTBi1Ae7bEBn6UeM5AokbaoR1iLDzEpNATnmkvFjrsr1VMBA921L9cue
         l1X4thgtOubxzTZw5I316/y46xeGFDGIcvLAiYT9uI6dd7PKoyPpljj2Thkijs2bVWsv
         sxU909NYujEYOs6qOOLZ4CyZd5MkMMyuIrU8j/BRbDrx4ZUErkjbzXC3DcNuTgrFXdXm
         SlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fMDz2xpwi7cRAmLy/VBoOICWddnk9d6wR55V0pIhA2M=;
        b=gYWKol8/cLxMOskRMQgKRbs9cVMpYPqwEb/UxQXI3qo4b0M+1uss8FXBSsNfuwV7ed
         BbouV5r/2Z1jJxrprdF2TUXxvhAhzvNQyAjPU9qn8KBFe7lRnN3AZz+L1FkPssmKoh63
         Vb6C+Y7m5/N2joopG26/8ZqlqcwM9dGCxdAvKGEVzfBAGy/qZGYuA1VgQEueAQZobdWQ
         Jh7OEayw9BkvW2tno2PO9XBH6nM2E4NAX2v1VsheHiv/cDoz/pYWz3taF4D93ptoE1do
         vlhnKeBLqIJjjP8OB0lN3Vlre+o8n5w6KiUcvFivHkDxDQZRPPfZ7i8pfU+xn6AVD19N
         VmLQ==
X-Gm-Message-State: APjAAAXgv0jGHW36bS/pytuSrUg4uA2ogsrGV7hFSEnUfIxB9LhX7lrB
        b5Ce+SprXBiWtBJ/Qfi9zRM=
X-Google-Smtp-Source: APXvYqxvm3hD7J1wwKo+TVE+Y5j+U6uwyYuIYQl9rtxWC/aMnuziflnkcA22FIIRl40oCBh23NNQlg==
X-Received: by 2002:a17:902:b58d:: with SMTP id a13mr3999221pls.283.1579340339535;
        Sat, 18 Jan 2020 01:38:59 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7sm10955192pjk.22.2020.01.18.01.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 01:38:58 -0800 (PST)
Date:   Sat, 18 Jan 2020 17:38:51 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200118093851.s3qynwkyi4ay2vqc@xzhoux.usersys.redhat.com>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
 <20200117084517.GA24082@infradead.org>
 <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
 <20200118004700.GD2149943@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118004700.GD2149943@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 04:47:00PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 17, 2020 at 06:02:30PM +0800, Murphy Zhou wrote:
> > On Fri, Jan 17, 2020 at 12:45:17AM -0800, Christoph Hellwig wrote:
> > > On Fri, Jan 17, 2020 at 04:38:24PM +0800, Murphy Zhou wrote:
> > > > To mute false alarm on NFS, which is reporting FIBMAP unsupported.
> > > 
> > > How do these tests end up using FIBMAP?  We really should not use FIBMAP
> > > in any tests except those exercising FIBMAP itself.
> > > 
> > Through filefrag(8)?
> 
> But do those tests require filefrag -B??

Not really. But filefrag will fall back to use fibmap.

> 
> --D
