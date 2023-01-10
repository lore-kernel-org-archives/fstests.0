Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C69C54EBC
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAJWu6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbjAJWty (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:49:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D4337268
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so2248670pjb.1
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfDnec9qbmTgRSFD9R1QXJlMPy1vdBjbqSM7pmLlMhc=;
        b=v71HvwRZzSAgQQHM5fZcz5rhage71nVj93KR8ilgMTb0oMIHdyHg00hLhHIxuuSvs0
         J2uQkYkFMXwn+dB2+omOqnYpjrFNId9TM7PliZscG4qRkWu44xiGC5QfY9kP4C04Y7vt
         lCf5ULKCaEJWdSEIRwxRdx7Q8sgZiP4ZyyPEYOBOn/BdsE7eU96xaWgL1BoABQ+cNTx0
         Akbgzh+OgexxBGmE+w78czkNFRJyurfd0FF1NfryL7EPu6aRS+uTmVfubi/e3VkpRoxY
         siScxcWyqZ8VkfA/oJvexvbIijfItsZFOXYifMzS0NPj2AaN6rOCzoQjdBc0cXxtrh8R
         jM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfDnec9qbmTgRSFD9R1QXJlMPy1vdBjbqSM7pmLlMhc=;
        b=WRHnRYuFLcelX9KSzxmTB1YAFgi4So16De1seGLNGhheKSwWqURjQp+5au2/vWZm05
         0VakIeiNj8oXSjsqlRO9+5sIjOCtmweYDSeIBostCnP4yjf53iyV0uZfMKAMy1dgL0cQ
         RmnCbuYkMDh2IIpjZ17saizu14fR93U+1Jy1TYS61yb0nBQpbjxim14GD23ZYlUeYdYH
         WEGKMWycQ1U0+boV37mKSgAA+6UFZI69dF8mbGF3A8JNWbdsmiVIgmx6rsMN23SDpU6J
         2qjf5DtH0HHBS9m5ND8ErkH5Zt9kXZT2CSdtL5kGEdADeAXppPGyAkf2HNgzG3uLvwCJ
         h+GQ==
X-Gm-Message-State: AFqh2kotbbTo8Uda1cYgBBXPROO5njWiAChcjUyYu0UIkaSnF156Hjo1
        1d/FIC7j+ctF0auB8Hasz+vAa/8+WWy4cYDT
X-Google-Smtp-Source: AMrXdXs4Hew5KbJLbf6Evm8V/OwLYklf9prE7dJ0e+IWcpvNiWsBFD+LKGjrVcYLqkEx5eUs9MZ+vQ==
X-Received: by 2002:a17:902:be05:b0:192:a4e5:ac5f with SMTP id r5-20020a170902be0500b00192a4e5ac5fmr42989514pls.61.1673390951878;
        Tue, 10 Jan 2023 14:49:11 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001885d15e3c1sm8654752plg.26.2023.01.10.14.49.11
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:49:11 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pFNQa-001Yl5-Ai
        for fstests@vger.kernel.org; Wed, 11 Jan 2023 09:49:08 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pFNQa-004unI-0v
        for fstests@vger.kernel.org;
        Wed, 11 Jan 2023 09:49:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/3] fstests: filesystem population fixes
Date:   Wed, 11 Jan 2023 09:49:03 +1100
Message-Id: <20230110224906.1171483-1-david@fromorbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

common/populate operations are slow. They are not coded for
performance, and do things in very slow ways. Mainly doing loops to
create/remove files and forcing a task to be created and destroy for
every individual operation. We can only fork a few thousand
processes a second, whilst we can create or remove tens of thousands
of files a second. Hence population speed is limited by fork/exit
overhead, not filesystem speed. I also changed it to run all the
creation steps in parallel, which means they run as fast as the
filesystem can handle them rather than as fast as a single CPU can
handle them.

patch 1 and patch 3 address these issues for common/populate and
xfs/294.  I may update a bunch of other tests that use loop { touch
file } to create thousands of files to speed them up as well.

The other patch in this series (patch 2) fixes the problem with
populating an Xfs btree format directory, which currently fails
because the removal step that creates sparse directory data also
causes the dabtree index to get smaller and free blocks, taking the
inode from btree to extent format and hence failing the populate
checks.

More details are in the commit messages for change.

Cheers,

Dave.

