Return-Path: <SRS0=QNn/=3I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD7C3F68F
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F5C206B7
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 22:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QupRRIgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgASWCx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:02:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASWCx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jan 2020 17:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cWLMtNDd/EcuhVk+Yppg2fToCZ06Peh0aHjqkxNjPC0=; b=QupRRIgkYv272HmoFudagDwJ7
        fRLhfEyJt7w0lneQgFYOUqohNzRDT6aOUIoH63KRhUIwbxfXZxMcm0BzLl5zMXX5yG3JXGYptBVTi
        +Bu+OSK/2EoQK81v8u9Ry8o0Fita2tJvtedPA5JpZOfKJD3ddbpaUyQsg8KOfuGRJghOR4tYSnhCx
        3s6RT356hc+jki/kpESV+1Ft/XPDsgDMeDEAqj8Q7ZmBgFD2Ltd3/6CW1xffypwEb5Ij7WrrMIjb7
        YWy1B0i3kA5zeoSTDi85bWUocV36KoMQsDmZzox0TkbT8VtCehjuQBxcRXRKY6K5f4Oac57w3+urx
        5Z4v7oujw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itIei-0002cG-24; Sun, 19 Jan 2020 22:02:52 +0000
Date:   Sun, 19 Jan 2020 14:02:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200119220252.GA9313@infradead.org>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
 <20200117084517.GA24082@infradead.org>
 <20200117100230.gcvnheoh3rzddhg2@xzhoux.usersys.redhat.com>
 <20200118004700.GD2149943@magnolia>
 <20200118093851.s3qynwkyi4ay2vqc@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118093851.s3qynwkyi4ay2vqc@xzhoux.usersys.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jan 18, 2020 at 05:38:51PM +0800, Murphy Zhou wrote:
> > But do those tests require filefrag -B??
> 
> Not really. But filefrag will fall back to use fibmap.

But that means it requires either FIEMAP or FIBMAP, and your patch
will cause regressions for file systems only implementing FIEMAP.
So the fix isn't to ask for FIBMAP, but to implement FIEMAP in
any file system missing that support.
