Return-Path: <SRS0=0Rk7=6U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4994C28CBC
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F2720708
	for <linux-fstests@archiver.kernel.org>; Wed,  6 May 2020 18:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alviVLr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgEFSs1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 May 2020 14:48:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51193 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730145AbgEFSs1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 May 2020 14:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588790906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6mE3gBVpubwELhI23SYOvcrC3Rkj8u95MDZ81kuh48=;
        b=alviVLr96cIMJ/NlawvhvY6m5gdt9wHCqqE/99MP6qIxNSAX4zzpHPhz8i6iURqAx/cq9d
        Sdl7Za+76Ni8ttZs5OmotDjT8y7LcAVuDIKc7hytzCtPljcGX4bBaBGxLYUeQojgYdVGW0
        evPx0gvukSlB0Uj5gfHhr6trwnPDkUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-RtXPQz8JPSm8GcdaUFSMkw-1; Wed, 06 May 2020 14:48:24 -0400
X-MC-Unique: RtXPQz8JPSm8GcdaUFSMkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE8280058A
        for <fstests@vger.kernel.org>; Wed,  6 May 2020 18:48:23 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9377D19451;
        Wed,  6 May 2020 18:48:20 +0000 (UTC)
Subject: Re: [PATCH 2/3] fstests: test restricted symlinks & hardlinks sysctls
To:     Bill O'Donnell <billodo@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <294c5739-ff30-285c-8cf7-11a6dff98294@redhat.com>
 <20200506184437.GB152947@redhat.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <58bb57c3-2a35-3d29-b994-3072307b006b@redhat.com>
Date:   Wed, 6 May 2020 13:48:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506184437.GB152947@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 5/6/20 1:44 PM, Bill O'Donnell wrote:
> On Tue, May 05, 2020 at 03:20:10PM -0500, Eric Sandeen wrote:

...

>> +OWNER=fsgqa
>> +OTHER=fsgqa2
> 
> Why fsgqa2 instead of 123456-fsgqa?
> Thanks-
> Bill

Yeah, not quite sure what to do about that.  That username is somewhat specific
to test generic/381 because it wants to test usernames starting with digits.
I hate to proliferate required users, though, so not sure what the best way
to go might be.

I could maybe/probably use root as one of the users, but didn't want to
over-complicate it with matching admin privs vs. normal user privs.

-Eric

