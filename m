Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B8C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Mar 2021 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE4F64F5E
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Mar 2021 10:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhCQKL0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Mar 2021 06:11:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:48325 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCQKLI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Mar 2021 06:11:08 -0400
Received: from [100.112.193.211] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 47/0C-24644-AB5D1506; Wed, 17 Mar 2021 10:11:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRWlGSWpSXmKPExsViZ8MRorvramC
  CwdO1yhanW/ayOzB6fN4kF8AYxZqZl5RfkcCasab7CnPBJZaKU5POMDcwNrB0MXJxCAm0M0m8
  alnODuHsZpR4NPcmaxcjBwebgI7ExOkCXYycHCICshL/Z6xmArGZBbQkpuy7yg5iCwv4Syxe+
  wTMZhFQlTh+fjUriM0r4COxbO4BRhBbQkBBYsrD98wQcUGJkzOfsEDMkZA4+OIFM0SNosSljm
  9Q9ZUSezY/ZJ3AyDsLScssJC0LGJlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGloCsZGZXmKVbqJ
  eaqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZgcKUUHKjbwfjg9Qe9Q4ySHExKorymLYEJQnxJ
  +SmVGYnFGfFFpTmpxYcYZTg4lCR4Ra8A5QSLUtNTK9Iyc4CBDpOW4OBREuHVBQa7EG9xQWJuc
  WY6ROoUo6KUOG8CSJ8ASCKjNA+uDRZdlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8yqBjO
  fJzCuBm/4KaDET0GJDaT+QxSWJCCmpBqYnb/bqNErvL0ma9HJx523bU24X+5fMW3015KX4xv9
  y5cZLVdON5cXzvZzNezTkjv2ynantxD6HxSXIn83Gq2fWxJfSRW7Wim8vPpzYo/rKdcq0nGY+
  Q47g/07Tej7mBWc+WSR1a49DouyNLJ/zTwU5HvKyzS0TTOLrvKv+66VUQ31v1aML6YYr3T+l2
  hQxaV0XULv3+VeGh+PfycVB3xsst6vd0v665VykWGnZIbvsq1HJvKtutvfU/43h+ZGePL1LvD
  paZMuCOYkGd9LzFqsLzNo+sbngmj9TpeEdRXOGXWlT1hx7Gr1tHtfz6uRtupHXn1QcZ1+ms2D
  pp4aI3X80PdZ0MppufsTkz+sioMRSnJFoqMVcVJwIAK7Jn94pAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-265.messagelabs.com!1615975865!80633!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23363 invoked from network); 17 Mar 2021 10:11:06 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-9.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Mar 2021 10:11:06 -0000
Received: from r01ukexcasm111.r01.fujitsu.local ([10.183.43.167])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 12HAB3d7029035
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 17 Mar 2021 10:11:05 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM111.r01.fujitsu.local (10.183.43.167) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 17 Mar 2021 10:10:59 +0000
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] src/chprojid_fail.c: Fix undefined compile error on old kernel
Date:   Wed, 17 Mar 2021 18:11:13 +0800
Message-ID: <1615975873-19206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM111.r01.fujitsu.local (10.183.43.167)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On old kernel, linux/fs.h doesn't include FS_IOC_FSGETXATTR and FS_IOC_FSGETXATTR
ioctl flag. It also doesn't include fsxattr struct. To fix this error, just
use global.h like fsstress.c.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 src/chprojid_fail.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/chprojid_fail.c b/src/chprojid_fail.c
index 8c5b5fee..6d1e0fac 100644
--- a/src/chprojid_fail.c
+++ b/src/chprojid_fail.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <errno.h>
 #include <linux/fs.h>
+#include "global.h"
 
 static char zerobuf[65536];
 
-- 
2.23.0

