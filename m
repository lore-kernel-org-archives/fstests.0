Return-Path: <SRS0=9PQ0=6T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5A7C47247
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766222068E
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 20:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bejlo+SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgEEUQk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 May 2020 16:16:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46153 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbgEEUQk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 May 2020 16:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588709799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I69Qey/sXnfMOSyhASvj1yZ/z/ENSfABIcXKWlVOkqA=;
        b=bejlo+SCRUCw4TE2QwEcfpmcQGQJoT8XzRvtow90DQFgaMrqKUMwRlg4Wv4oRkknCbPmlO
        v/ibFDOUalahDa1k6jQ0pwAeoSukCQOUHfRkF1EC2kZq+wvJeNpIwYxLSahONFUVWx59s8
        bUe/GocbAkgw8E565TjwfrRpP48Mfp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-9IzMUbviP8iH53nPxHqvWw-1; Tue, 05 May 2020 16:16:37 -0400
X-MC-Unique: 9IzMUbviP8iH53nPxHqvWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA2DE800D24
        for <fstests@vger.kernel.org>; Tue,  5 May 2020 20:16:36 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 825A45C1B2
        for <fstests@vger.kernel.org>; Tue,  5 May 2020 20:16:36 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/3] fstests: test restricted file access sysctls
Message-ID: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
Date:   Tue, 5 May 2020 15:16:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a series of tests which test sysctls which restrict file
access under certain conditions:

fs.restricted_symlinks
fs.restricted_hardlinks

and

fs.restricted_fifos
fs.restricted_regular

