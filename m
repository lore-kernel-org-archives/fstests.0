Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F1C33CB1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 10:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D332073A
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 10:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN7899Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAQKCj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:02:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53873 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAQKCi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 05:02:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so2938891pjc.3
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 02:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32mppyfjNa/1kochSaBd/2MG7qomb0BrnEGO3GlP/rM=;
        b=pN7899FoqCrF9qzwM6oU/LdCaJasrup3IRhxj6LsQk9GkLKRcFhi1q/FWRywBOscJG
         t1Rfti/3wUI8ls6sR2c12pgLIdR4pCkvUp4SEZBNCToFhQC80utNtCPGqtNSiVdOhZBv
         8aZgo3ht5nFRXQ+htvQuwdrIrTMKDLX3dVftodcKH8q/IIK5mtdea9h+M/WYX5wPAQHP
         VZlOa3YEkexiPvb/ADFSLL2L7vaJP/5CdWsEoYrVSQp+PjHzY0WSUXDOCrnsa76H/1jj
         0WfxdshFWw0ryBgoYr0Fpl4QA2dS9UBpKJa0lwmT3hncreuvqki1OBRc+/imLVFQyb+6
         wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32mppyfjNa/1kochSaBd/2MG7qomb0BrnEGO3GlP/rM=;
        b=DbstowSsjbZYRi9Lo8hhLxAiTdAGmbk2ELQZxwjsLGu8eOgtsyv10pwRSy0JZ60MkM
         HjeRr33RkAZDan2gQgAzSU4Tu+l+GliPS+LBV0gvW69UDwVe1wG9YgoLR1itGgu84w7L
         UYwfW6lx82xvk/4XspQvtzqQ+tg+LPhjPvOUrPV1AszhZIy09K1K9CulmzyyhPEgqKHY
         /gY6WPtYhliHmr8oP6OvelIOKMjKOAGNviWw5ga/f+hc/Z/+EqNKr5jKf8r2Ing3tT1l
         FPY9VbUdCU53pAaZa8julqk/gX9+pcxh9LyiWomATdwycPk6LF/ltESbveeLRm/qBJV2
         uaFw==
X-Gm-Message-State: APjAAAWHZZLXbKX7iMv8zD7imQGHYWINBiyN/mU0sJqQiWEC0fQBfMsb
        T+ncocvWV6PbAi/bg7RWOQw=
X-Google-Smtp-Source: APXvYqw0ol0yadduM2Tx3X1cFMohmLcghlS6bTBncyCNfoigQsNuG/c3OZvnpwJ5/sLVTMqWapgViw==
X-Received: by 2002:a17:90a:be0d:: with SMTP id a13mr4695404pjs.78.1579255358123;
        Fri, 17 Jan 2020 02:02:38 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i9sm29462197pfk.24.2020.01.17.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:02:37 -0800 (PST)
Date:   Fri, 17 Jan 2020 18:02:30 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
 <20200117084517.GA24082@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117084517.GA24082@infradead.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 12:45:17AM -0800, Christoph Hellwig wrote:
> On Fri, Jan 17, 2020 at 04:38:24PM +0800, Murphy Zhou wrote:
> > To mute false alarm on NFS, which is reporting FIBMAP unsupported.
> 
> How do these tests end up using FIBMAP?  We really should not use FIBMAP
> in any tests except those exercising FIBMAP itself.
> 
Through filefrag(8)?
