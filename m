Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72177C636CD
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 20:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjA3UM0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 15:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjA3UM0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 15:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42A2FCDB
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675109509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiGAQ28uVHeBQ88bxG6ZF7FoKC5LZZUEtjyH82592Zg=;
        b=JdMm+xODWZ7QuCtecFVcn+nVJxQxJq/o/GmeViHZvAQJ+bSON6uKh/5RY+dHfJk0aZeRWG
        O6OhhVlwI55SJdg+Uy3WU+KqvgcqVZn8Aglfz0dLRCVsYFfrWS2nwHO+fFrKPZdGYNlrJt
        v1xiLr5zeNMTj88JJlaqWIf/I20/CF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-u_RgoN5jMSKGrjd4mOh0mA-1; Mon, 30 Jan 2023 15:11:45 -0500
X-MC-Unique: u_RgoN5jMSKGrjd4mOh0mA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE5B2101A55E;
        Mon, 30 Jan 2023 20:11:44 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB7B6492B05;
        Mon, 30 Jan 2023 20:11:44 +0000 (UTC)
Date:   Mon, 30 Jan 2023 14:11:43 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 0/4] fstest: fix compilation warnings
Message-ID: <Y9gkfwzV2qU1YWi7@redhat.com>
References: <cover.1674870429.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674870429.git.anand.jain@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 29, 2023 at 10:42:29AM +0800, Anand Jain wrote:
> This patch set addresses several compilation warnings and is based on
> the for-next.

Good idea. The warnings have become pretty distracting. Thanks.
For the series...
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> 
> Anand Jain (4):
>   fstests: doio.c, fix missing initialization of -C arg
>   fstests: fstest.c, fix compile warnings replace sprintf with snprintf
>   fstests: t_getcwd.c, fix a warning related to buffer overflow
>   fstests: aiodio_sparse2.c, fix compiler warning buffer overflow
> 
>  ltp/doio.c                           |  1 +
>  src/aio-dio-regress/aiodio_sparse2.c |  1 +
>  src/fstest.c                         | 17 +++++++++++++----
>  src/t_getcwd.c                       |  4 ++--
>  4 files changed, 17 insertions(+), 6 deletions(-)
> 
> -- 
> 2.38.1
> 

