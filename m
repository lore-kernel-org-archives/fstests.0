Return-Path: <SRS0=XlT/=7D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1900C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B468F207D3
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlUjC9Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgEUJ1I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 May 2020 05:27:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbgEUJ1I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 May 2020 05:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590053227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZHKIQTkOVax/IQhxMsfdyJQHpuZZU5+4oj7pe7G2r8=;
        b=OlUjC9Ep15lFGH3WM1TIyk+ocB+fVawwEzlR8k+aJcMFqZxW2wxrjfOsAyiq74FBj59cnq
        majx/7RKwcfXlS59/1d3P4N47aoUu2u9Xn/7y/SRRcT1dxulq0amlnwPDRjlPztZRjexMc
        fbSUyX/KQnZEbf96sHndGpB1xz9OzQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-fEiCGV87OsqRGmKPwY8Z4A-1; Thu, 21 May 2020 05:27:05 -0400
X-MC-Unique: fEiCGV87OsqRGmKPwY8Z4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C5B31853C6A
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 09:27:04 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0022F82EEA
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 09:27:03 +0000 (UTC)
Date:   Thu, 21 May 2020 17:38:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 0/5] fstests: recent series rollup / misc tests & fixes
Message-ID: <20200521093821.GE1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests <fstests@vger.kernel.org>
References: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 18, 2020 at 11:10:16AM -0500, Eric Sandeen wrote:
> Resending the last few of my patches as a series, with requested
> fixes from Eryu, plus one more new one.

Just a tiny problem as [1]. Others looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

[1]
Applying: fstests: test restricted file access sysctls
/root/git/xfstests-dev/.git/rebase-apply/patch:61: trailing whitespace.
_require_user 123456-fsgqa
warning: 1 line adds whitespace errors.

> 

