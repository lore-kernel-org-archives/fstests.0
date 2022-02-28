Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC67C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Feb 2022 20:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiB1Uah (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiB1Uag (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Feb 2022 15:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37A85245B6
        for <fstests@vger.kernel.org>; Mon, 28 Feb 2022 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646080195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B6wpFFwQPPpYWOeq5Ii+STA5OqyDcsW59GnpgQ1G0qQ=;
        b=R2T+7VVxHR7zPqHToKQzt01V+thkrNlKZ7MwKT4KiOb0GQG3YJ+/o6k5HnKYAj4gfqxAZ3
        TCWU/hXy14IoLsz8zpHg2ukBnPnjDZrcGPnWsBqU2J54rNfvb2rGGdD0WzHdw57vYNr5Yf
        8wfBDWKO9cDDYTcR646bY8oOcwvp0Y8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-t57N3KXYMy2Q65SbSAj4Qw-1; Mon, 28 Feb 2022 15:29:54 -0500
X-MC-Unique: t57N3KXYMy2Q65SbSAj4Qw-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso6548316edh.6
        for <fstests@vger.kernel.org>; Mon, 28 Feb 2022 12:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6wpFFwQPPpYWOeq5Ii+STA5OqyDcsW59GnpgQ1G0qQ=;
        b=Pe3XAvr/z+S+xpZI3b6pptmET5v0INPV4IS58abJFRooWhU3d1SmFxTk9+EkL8yEf/
         +BbPFOhpDQk2D38+UYl+iDid9ynNlZ4rhMgH4erQ+5V+RyjqqPKQ1SQi68Boj9MzeXf2
         YHKena+0xCRQ7caGMnmRVGeEgKRRoXj6aph8hD1QRK/an12DB6hOIQugGM+Hi/B9nEsT
         YztKgawT5d12Ldv8ucQL94LSAoQ4ogFMwu3+MCLGyFCRd7KX1/0tf1kN9FNI7JYOlOUb
         kt1ctyfC+C+9GvxobuBOOsfBvuXc5iX9TaoMlDY/hf+lxcwrGcJGLDxJsSjoUnK/mWFu
         QFTA==
X-Gm-Message-State: AOAM5330KzN5bc8plCqelc5Ave8txXzx8VnEaE+wJgd76XNGB7YY8h3u
        QxxQBTkY73EdpmRDkJGX328+xNRtTshNdhJb8MQnYKRKdO0VoJBHWp6w/Wqg3GQc7WwuUYKfcGY
        isba/xtPD0qnbdptwUfzXPlb7kJxBrxFYmOuRzAXWfqFvbOlrae77FefSJyV8ieo+bKTU
X-Received: by 2002:a17:906:2859:b0:6b8:d27c:8e58 with SMTP id s25-20020a170906285900b006b8d27c8e58mr15745412ejc.609.1646080191245;
        Mon, 28 Feb 2022 12:29:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPFqEAvOjD1HNFDUeBkBgORtnQwGCuTQRS+frKcnlcFkNVR70kPazUxhMqmovK/cPSedWIRg==
X-Received: by 2002:a17:906:2859:b0:6b8:d27c:8e58 with SMTP id s25-20020a170906285900b006b8d27c8e58mr15745399ejc.609.1646080190982;
        Mon, 28 Feb 2022 12:29:50 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id gb11-20020a170907960b00b006d20acf7e36sm4847327ejc.144.2022.02.28.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 12:29:50 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 0/1] README: restructure & format building manual
Date:   Mon, 28 Feb 2022 21:28:48 +0100
Message-Id: <20220228202849.183568-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I'm new to the xfstests, I've tried to set things up for testing and
found out that building manual in the README is not up-to-date and a
little bit difficult to follow as it's not clear which steps are
necessary to get started and which can be skipped.

In this patch I updated installation package list commands and
restructured "BUILDING THE FSQA SUITE" section. Package list is
up-to-date for the latest distors (Ubuntu 21.10, Debian 11, Fedora
35, RHEL 8).

Changes since v1:
- Formatting of package manager commands + move XFS packages to
  second step
- Separate Fedora from RHEL/CentOS in package installation
- Separate partion creation in to different steps
- Move fsqa user/group creation and udf_test to 'Setup Environment'
  section
- Improve example (xfs_io instead of dd, no mkfs/mount on scratch)
- Variables in 'Additional setup' divided into groups
- Fix formatting issues and clarify cluttered parts

Andrey Albershteyn (1):
  README: restructure & format building manual

 README | 372 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 235 insertions(+), 137 deletions(-)

-- 
2.27.0

