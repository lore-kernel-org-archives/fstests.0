Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD79C433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55B761996
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhC3WAa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhC3WAL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Mar 2021 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617141610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A2MAf3ZxCpGaLy6r3LCZjoqm2+WC8j5lGIvgUIyj4GE=;
        b=VKWUArdwsC9Oa2Q22JliksFqyzAFCDDMrg/C1imA1IQZqvCccBX6ouQxuUpbnGJS2XyQ3Q
        eIbDFvYsTVYeULkumnoiKkRyQ789nkgoYWzYSaVqxOOqIx70SpVRwTZSo3e3Hh5C5wkNb+
        h561d+WOMmOr+Askq9EgZJ1tP3Q+FK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-hV1PKhiAM4mJp3VZ17bqqQ-1; Tue, 30 Mar 2021 18:00:08 -0400
X-MC-Unique: hV1PKhiAM4mJp3VZ17bqqQ-1
Received: by mail-wr1-f70.google.com with SMTP id o11so10961430wrc.4
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 15:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2MAf3ZxCpGaLy6r3LCZjoqm2+WC8j5lGIvgUIyj4GE=;
        b=mhczCIW01HJ2xnldDGKqn4bXuHU4bUc93KMsp0MEPjxKyWmAoJt9fv0fFMp0aFVPCS
         tSxn07hfjbKR4mS4Y6FLJ/WwLbM9/7ZCGoTvwPJzh65FLQ0Gb0nQJ85+SY5lYOY7Dn21
         OhgcSX+pMwk5BeFRDYlQY8Xg8R0xWJnZ1Vy2A+zr9YqAKG67nVHH0rQ6RW3KlcjJaDc9
         hEQbea0fshPCpgERMMYM16JfPqV31QYJwhQV4uzjjdCWKUJ5PMQn6IcLrkJHHtp7kjOJ
         D840KZERA453FSJaiSCxbgbxGCCmLL1C0z9DW7Nr6Ma0B0elJaxaNC+mvpvZniCraaxZ
         SKhg==
X-Gm-Message-State: AOAM531OUmhuwTBeiFf1ps3fh/RVziWNGWgpVHjwort45pREFO/kUW2o
        4bJwwLZn1lvAeYh3ia/DvfXmc/bZ/1Vce0yJO3faCbya0ak4S4uZf0VLpp/eGh4KmBNmEH/rt7D
        Xu31R7VhJchUdb+QqD5JChVFCIazcueqZVNet7K2VlHcUmcdqDC3wxoUzegSRMi9kfKET
X-Received: by 2002:a5d:4521:: with SMTP id j1mr121003wra.354.1617141607294;
        Tue, 30 Mar 2021 15:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAjByjsMT/Nb9V18WHvLDhcYHPD/vcGRh1YAJa6nBQsDxSXMqYqOdZ3GGSsw9QF4RBGdM0uw==
X-Received: by 2002:a5d:4521:: with SMTP id j1mr120990wra.354.1617141607147;
        Tue, 30 Mar 2021 15:00:07 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z2sm522894wrm.0.2021.03.30.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:00:06 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
Subject: [PATCH v2 0/4] Fix some tests that fail for exfat FS
Date:   Wed, 31 Mar 2021 00:00:01 +0200
Message-Id: <20210330220005.56019-1-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mostly just do not run test that require posix permissions and ownership.

Changes in V2 (Thank you for comments on version 1)

* Merged patch #1 and #2 (the one introducing the helper and the other actually
 using them)
* Fixed generic/597 by introducing _require_symlink
* Fixed generic/598 by adding _require_chmod
  ** changes are part of patch #1
* Introduced _format_swapon_file()


Pavel Reichl (4):
  common/rc: Add _require_{chown,chmod,symlink}()
  common: hide permision warning from mkswap for exfat
  generic/554: hide permision warning on exfat
  generic/003: Amend the test for exfat

 common/rc         | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
 tests/generic/003 | 29 +++++++++++++++++++---------
 tests/generic/087 |  1 +
 tests/generic/088 |  1 +
 tests/generic/125 |  1 +
 tests/generic/126 |  1 +
 tests/generic/128 |  1 +
 tests/generic/193 |  1 +
 tests/generic/314 |  1 +
 tests/generic/317 |  1 +
 tests/generic/355 |  1 +
 tests/generic/554 |  3 ++-
 tests/generic/597 |  1 +
 tests/generic/598 |  1 +
 14 files changed, 80 insertions(+), 11 deletions(-)

-- 
2.30.2

