Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB7C43460
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B0561249
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhDOJtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhDOJte (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618480151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yLLO0dNiCX+d3yDdP2QLyTxQyjlGn5mNptLz4HwrOzM=;
        b=h/h0KaBirF4SURyueY3Lhx/uf16PybFlf9f8kfP4JW8f4muMRYQaWxcAHNv/gYlDNMszAs
        zE3VPkgP7Ylm/6pDcV64RuPn5FOgTZRQ01i9r8OrEJCsc5ffQPpfGtEC0m9ygESkBBvw4T
        NqNUNvr4XApyRjb+2T8OOb/BhLkJdeE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-uZEn8-54NEOcafWQWbFlTA-1; Thu, 15 Apr 2021 05:49:07 -0400
X-MC-Unique: uZEn8-54NEOcafWQWbFlTA-1
Received: by mail-wr1-f72.google.com with SMTP id 91-20020adf92640000b02901060747826eso792916wrj.13
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLLO0dNiCX+d3yDdP2QLyTxQyjlGn5mNptLz4HwrOzM=;
        b=asmqdBpSbulFH8Vq0HSPALlW71FU6MEjUSQsode2ybS6ekHWYSKRfYkB9//kdUqiGA
         TUyZYNejdVF7ERFP/O/rmO6f1HDRmtV0ztQBXm4L+fkIfNbe0FM5flePGEopp2ST2UkI
         hCOAyyJPmX4okw6YN13eHQWiQOYotkqin3xhYMYDJHmFAK+3pX4unjwkuHOwnWJywrof
         cf3HeuKgVvBtgIqIzjxDgoave1S3nYF+mbeehbOuT5uQTH/gLI1VHQs8y9VV3mF7C0J4
         XPwmJTFGDkxWqKcyPH/MFQBOK14Zz8F2EIjD8v9UdZDvPVODhjMTQnPa9HxSb+lmtZSm
         17Bg==
X-Gm-Message-State: AOAM531XknlSlnNNIZXcAl6mAvDFXEoPNLex180h9OSWT1/+wl7EhsWG
        Y/uWEiM9QiaT3LnhyINK12OF8sMz1qHF3liLC62ZYC6RguGLrLHps7mQe7ZRMzfIqx5iN/vUTl1
        Ul2otS+JiUhu6TkAxOFAnMxc0iZQwbfs+R+LTe27O7Q67jxIeHptqOnXGGyqFf4r09Np1
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr2499147wrw.238.1618480146475;
        Thu, 15 Apr 2021 02:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2O70PdXCYEC75s2AMkPATP5qpSCGoYIuwXBeStpMUv/UI6dcC+inavac0nU+6k0O+uemhTw==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr2499131wrw.238.1618480146237;
        Thu, 15 Apr 2021 02:49:06 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v4sm2427278wrf.36.2021.04.15.02.49.05
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:49:05 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 0/4] Fix some tests that fail for exfat FS
Date:   Thu, 15 Apr 2021 11:49:01 +0200
Message-Id: <20210415094905.61853-1-preichl@redhat.com>
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

Changes in version #3 (thanks for the comments and hints!)
* reuse _require_symlinks() instead of introducing _require_symlink()
* implement _require_chown() so it actually checks if chown() is supported.
* Don't special case filtering of MKSWAP_PROG's perm. warn for exfat only.
* Rename _format_swapon_file() to _swapon_file() and also don't special case the perm. warning filtering
* Increase the 'access_delay' by 0.1 s for the exfat to be safe.


Pavel Reichl (4):
  common/rc: Add _require_{chown,chmod}()
  common: hide permision warning from mkswap for exfat
  generic/554: hide permision warning on exfat
  generic/003: Amend the test for exfat

 common/rc         | 33 ++++++++++++++++++++++++++++++++-
 tests/generic/003 | 29 ++++++++++++++++++++---------
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
 14 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.30.2

