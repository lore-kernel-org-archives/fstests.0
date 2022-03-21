Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A4EC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 11:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiCULFd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbiCULF1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 07:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D39F714AC8C
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647860631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c0jsj00GJsxisvpk0Lpc2/7jBKlmBY/TCPwv/rKmjuA=;
        b=VnNZX7iFyJMWXhC90cEOop62DxD1gU3ywQKAUNzmer9tH02R7rM89thljh1LwmzZfZ+OqG
        9OJCoR81n6DmB1EmT2JPdHvrgAbM0kbnQq+lLh6imA+TvypQiWdXFQo28KI3FSeWJn3QqH
        BJDfIBk8xL3QDUTbgpOT1SqzN5hD2Ww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-iQYNsX_iNvOWvEdJuDdR4w-1; Mon, 21 Mar 2022 07:03:47 -0400
X-MC-Unique: iQYNsX_iNvOWvEdJuDdR4w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56A2C80029D;
        Mon, 21 Mar 2022 11:03:47 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-13-229.pek2.redhat.com [10.72.13.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7093D42D447;
        Mon, 21 Mar 2022 11:03:45 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org
Subject: [PATCH 0/2] xfstests: hexdump and CVE-2022-0847
Date:   Mon, 21 Mar 2022 19:03:39 +0800
Message-Id: <20220321110341.1323882-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset contains 2 patches:
[PATCH 1/2] xfstests: replace hexdump with od command
[PATCH 2/2] fstests: test dirty pipe vulnerability issue of CVE-2022-0847

I've sent the V2 [2/2] last week[1], but due to the [2/2] hasn't been merged
and the [1/2] will affect [2/2]. So I send these two patches in one patchset
this time. Just please note, the [2/2] is the last version.

[1]
https://lore.kernel.org/fstests/20220320123932.1000005-1-zlang@redhat.com/

Thanks,
Zorro

