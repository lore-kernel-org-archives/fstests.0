Return-Path: <SRS0=Vcut=7A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_VSHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FCBC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6261420674
	for <linux-fstests@archiver.kernel.org>; Mon, 18 May 2020 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPhMJtc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgERQKW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 May 2020 12:10:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32321 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727005AbgERQKV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 May 2020 12:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589818220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XLJKd3dYBzExCZurRSRPx9rQlMVsOMRhA5F/xCY6lnI=;
        b=DPhMJtc9Mhj0KYedl0zCDTf4hka2PAnYHugRFFjh/6oMxdJSiUEPTWpi4HN46zO+C1cPeE
        Xv9WpE1lCuP1R6YPr1nbxGAXRUzRdldubeC6Q5EwwjLeJDOROIutyZl3UzMR6O30WzX3SS
        4yFIlCZCJgDyp5BiUCzAWG4bKnoJ2sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-KdHAEZ6fMLy-4SKLTyXxkw-1; Mon, 18 May 2020 12:10:18 -0400
X-MC-Unique: KdHAEZ6fMLy-4SKLTyXxkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B521800D42
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:10:17 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 765DC5D9DD
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 16:10:17 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/5] fstests: recent series rollup / misc tests & fixes
Message-ID: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
Date:   Mon, 18 May 2020 11:10:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Resending the last few of my patches as a series, with requested
fixes from Eryu, plus one more new one.

