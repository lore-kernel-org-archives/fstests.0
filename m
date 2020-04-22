Return-Path: <SRS0=NJCV=6G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFABC54FCB
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9567C20767
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mguo8uGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVTj0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:39:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVTj0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Apr 2020 15:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587584365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAZqCBiRzMDqzg64n8IwDaKN+tIF+F8BkN3v5jtHaUE=;
        b=Mguo8uGWGbslXt5csvq0tNnzRUP1v7aYMsHX2bN+iOfr7nBGjuOJpP/ltCfIpiLgqHIq0C
        PlFJ3nvjScNlK1awgWcgScq/HgkXvE9vmi6pwVrB43Q0QpXK1TCX+nlu4BGubnnkFUcXD5
        4RzAJgLXf76xxkbtqYuN3oSKwMk41OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-H1nuYkUnNDONH8CVYsiAEQ-1; Wed, 22 Apr 2020 15:39:21 -0400
X-MC-Unique: H1nuYkUnNDONH8CVYsiAEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4019A107ACC9;
        Wed, 22 Apr 2020 19:39:20 +0000 (UTC)
Received: from work (unknown [10.40.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B5C2600DB;
        Wed, 22 Apr 2020 19:39:19 +0000 (UTC)
Date:   Wed, 22 Apr 2020 21:39:16 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: ext4 mount sanity test
Message-ID: <20200422193916.ovvisziwqo5teov3@work>
References: <20200422152012.28588-1-lczerner@redhat.com>
 <20200422174212.GK3372712@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422174212.GK3372712@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 22, 2020 at 10:42:12AM -0700, Ira Weiny wrote:
> On Wed, Apr 22, 2020 at 05:20:12PM +0200, Lukas Czerner wrote:
> > Add test to validate that the ext4 mount options are properly recognized,
> > validated and applied to avoid regression as ext4 moves to the new mount
> > API.
> 
> When is the new mount API work slated to be done?  I must have missed the patch
> set.
> 
> Ira

I'll be sending the new patchset soon - probably tomorrow.

-Lukas

