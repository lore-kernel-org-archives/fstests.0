Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA51C07E96
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359F761874
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhGHQiK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jul 2021 12:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhGHQiK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jul 2021 12:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625762127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bUhzExGImRWjgeyZN/8X5PubdkDAOV2H7reS635XnaA=;
        b=fTz1ukNSz1+cN43gfz5aQBBcgGDON1hUSJAO+2ysUE0V1DrdcH/C2AvAbV3LmXqruR9WZ5
        sCZZ3wW4XHOiRJE4QUw4FEeRpDaOBLP1NsoNpsRPaUF1W7QwKmnbqdSAXsfFNFraTgrFlt
        Ucdglw4qpmJ2g9NZqE3b95XXWnMZLeE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-uFeg9KpzOVK7ZmY5v99bxA-1; Thu, 08 Jul 2021 12:35:26 -0400
X-MC-Unique: uFeg9KpzOVK7ZmY5v99bxA-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso2078670ejo.13
        for <fstests@vger.kernel.org>; Thu, 08 Jul 2021 09:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUhzExGImRWjgeyZN/8X5PubdkDAOV2H7reS635XnaA=;
        b=lOEtPNlFO99uTEEnN7PCl99eaycb8RPJymXPvcvYSxb7sb1nJUpYZhkq/wLlYP8qRj
         n7DoVoKe64WaJyx51466OvZZvnA4lrpgqP3+zrUne4wJNcMlabpPvUmYCXhrmI36xNQu
         VjKaSATPNQfqLiMS6VMPEi0i1gD7yFkHzqMA1tdT2TpTeDNxwpcCbS/H8ePpkD26dVG1
         70y/UMmPMEHkyMJq441RHl9RG2H/32RIW8UV+eohtYN9L07VPbZM1ST2vLwOjTF/qFWP
         BZhfkSwqKe5RMfADMsutls5DVVHpKRW8d2lxxtNMZZ5JqOTkEDwY/OkWAN+MZqrhafsH
         1Huw==
X-Gm-Message-State: AOAM532vOWSUdjKRiY+6yxO2A861lDsy4VRcqMsfEi/mSt+lDfq2O5We
        /7FVm3oNVRMfWIRsdwDAIP+S/wWYkb7PCLkK7C6kZxbD0+OV4EXOEM2TlD/dU9l6Twhx0te5AOO
        m4KploWGf4uHEvjKNVpqkIePA9h8AMhsJsyLSPbVZwH1kJh88lv83FCZIWm+I5bZ8rDEx
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr38208479edb.375.1625762125300;
        Thu, 08 Jul 2021 09:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEWUVXRZLtKb2JU1BVUlbmTdNQfw7kJod1Q6Vgty0QNVwjBkO7rdTyNpaSgNMLvgFTkGliDQ==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr38208451edb.375.1625762125073;
        Thu, 08 Jul 2021 09:35:25 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v7sm1663491edd.4.2021.07.08.09.35.24
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 09:35:24 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 0/1] generic/{453,454}: Do NOT run for FSs restricting names
Date:   Thu,  8 Jul 2021 18:35:17 +0200
Message-Id: <20210708163518.51386-1-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

this is a quick attempt to finish what was discussed in thread:
	generic/453: Exclude filenames that are not supported by exfat
	https://www.spinics.net/lists/fstests/msg16328.html

Based on Darrick's comments:

"""
TBH I think these tests (g/453 and g/454) are probably only useful for
filesystems that allow unrestricted byte streams for names.
"""

and_require_names_are_bytes()

"""
Nowadays with wider testing of other filesystems (thanks, Red Hat!) we
should hide these behind _require_names_are_bytes or move them to
tests/xfs/.
"""

Changes in V2:
* Added description for _require_names_are_bytes()
* Added _require_names_are_bytes() to g/454 as well
* fixed typo s/now/not/

Changes in V3:
* Added f2fs to the list of FSs that treat file names as unrestricted byte streams

Pavel Reichl (1):
  generic/{453,454}: Don't run for FSs restricting names

 common/rc         | 13 +++++++++++++
 tests/generic/453 |  1 +
 tests/generic/454 |  1 +
 3 files changed, 15 insertions(+)

-- 
2.31.1

