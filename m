Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFAC433E6
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0D664EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 17:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBRQ7z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:59:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232908AbhBRN0H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613654640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4csc1M0WUZ3sdBPqq+tbQ3PvNBAG3Ydp1qw44agJivE=;
        b=QcdXEXc3Q+Az/xoEA0fP+W6HVerc467j1DCzustChT8YxBnoeU7lhFwJK7tZFu9doj7qPv
        T01Q+7sEl66wBQeIIgVggT58cU6m38jGpWM9VLNOLZYX/Q/zH4DgSdqD/UCLdELNbpeFfm
        x/QZhi9tCKWTEUo+0y5WIYIu7IbDUA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Sm1C5mOfMcGg7Bm-xU0NcQ-1; Thu, 18 Feb 2021 08:23:58 -0500
X-MC-Unique: Sm1C5mOfMcGg7Bm-xU0NcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D87B1005501
        for <fstests@vger.kernel.org>; Thu, 18 Feb 2021 13:23:57 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B931362679;
        Thu, 18 Feb 2021 13:23:56 +0000 (UTC)
Date:   Thu, 18 Feb 2021 21:41:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
Message-ID: <20210218134134.GM14354@localhost.localdomain>
Mail-Followup-To: XiaoLi Feng <xifeng@redhat.com>, fstests@vger.kernel.org
References: <20210218085752.24123-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218085752.24123-1-xifeng@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 18, 2021 at 04:57:52PM +0800, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> Add _filter_testdir_and_scratch to avoid _test_inode_flag failed when
> mount point contains flag string.
> 
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 649b1cfd..473188c1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3112,7 +3112,7 @@ _test_inode_flag()
>  	local flag=$1
>  	local file=$2
>  
> -	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> +	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_testdir_and_scratch | grep -q "$flag" ; then

I can't understand that. Could you give us an example about why we need this
filter before "quiet grep"? I think this line doesn't have any output
(except xfs_io fails), so why a filter is needed?

Thanks,
Zorro

>  		return 0
>  	fi
>  	return 1
> -- 
> 2.18.1
> 

