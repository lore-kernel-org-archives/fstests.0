Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF4C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Jan 2022 07:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiAQHgO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:36:14 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.2]:44397 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237558AbiAQHgN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jan 2022 02:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1642404972; i=@fujitsu.com;
        bh=Uqxg6RsEW/MGpvc4ZF5v0MfzAZvxiAyWcBaADxyyK0g=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=VoIPhjsQZm7f7FUhJhkjQCh7AqOw6SUrTJoRnE+NnjsQAG1WMAK/TU0O1jxJFZXpd
         yUcW58M0t34YAMXpegHS/i8J9rrBGsLGMB5JhDBi1oY1U7QNmjQZMDRQ6wPhfQia1J
         3uLNGXGPzt07WRE9TYcHH4ZOA2MsHH+g5wl6mHHx516aLHm6sI9yTRSC5JPdVSXnPF
         OAkzYRZnd6Nlqzk82tObUjCg1fRxIvNTYliz87AlPDveHA1mYbcCZS6S4T1v32Ou5z
         uMm+lImdMoUCbLHCHH8WbaUkNUoF9qqJDbSwDJ1RgrojGXFSU2xLMacZlPFygHqqXw
         3T5wMvHU0S4mA==
Received: from [100.115.32.207] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 1C/67-27579-C6C15E16; Mon, 17 Jan 2022 07:36:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8ORqJsj8zT
  RYNJfNYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNeLfhIFvBVI6KFc8XsTUwPmbrYuTiEBK4xCix
  4NdR1i5GTiBnH5PE1ONKEIk9jBIzHi1nA0mwCWhKPOtcwAxiiwjISvyfsZoJxGYWUJdYPukXm
  C0s4C3x49Q/sEEsAqoSE74vArN5BTwkmp5dZAexJQQUJKY8fM8MEReUODnzCQvEHAmJgy9eME
  PUKEpc6vjGCGFXSMya1cYEYatJXD23iXkCI/8sJO2zkLQvYGRaxWiVVJSZnlGSm5iZo2toYKB
  raGiqa2ypa2Gkl1ilm6iXWqpbnlpcogvklhfrpRYX6xVX5ibnpOjlpZZsYgSGZEqxetAOxm8r
  fuodYpTkYFIS5Q358ihRiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSvtPTTRCHBotT01Iq0zBxgf
  MCkJTh4lER4iyWA0rzFBYm5xZnpEKlTjIpS4rxPpYASAiCJjNI8uDZYTF5ilJUS5mVkYGAQ4i
  lILcrNLEGVf8UozsGoJMyrAbKdJzOvBG76K6DFTECLV318BLK4JBEhJdXAdD416crc4qyJ3g6
  TnbK3Hd7glBFvFBrLEvpNj69FU/LlrJcexyufy+yUyPk2YcaSB49vnG6evOe/8hfDrRLVh25K
  6XB7FsTk9Yv/W3LC8Uv7+xCm6Hv2nckrqlq7khdbxhaaGHAnHZu/1Ub79nLPybe0RP/s/hNpd
  /2T5pZ3AdrP/n78eHXZHb8l7cdfS+RsiW3YlXYn0X2n193rnS82JW5T+X7bePMylZZEJccP8x
  cYXFev5gpe4/5v+9kfO59++lx3bvu9V+niKQaXtAvW+9i8XKqtHWeZELbw7I7khI3L02uTJN3
  iN6xe1qfcvNlfki1nlZRiVozNDN6WJ0FSxQfkV/XWrl1oEhfbvHc1txJLcUaioRZzUXEiADI0
  MKVEAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1642404972!178935!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14309 invoked from network); 17 Jan 2022 07:36:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Jan 2022 07:36:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 2A91A1001AD
        for <fstests@vger.kernel.org>; Mon, 17 Jan 2022 07:36:12 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id DD8A41001A8
        for <fstests@vger.kernel.org>; Mon, 17 Jan 2022 07:36:11 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 17 Jan 2022 07:36:02 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
Date:   Mon, 17 Jan 2022 15:36:54 +0800
Message-ID: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On my test machine, ext4/033 fails even use the non-overflow size.
It reports invalid new size when using strtoull because errno is 1.

As man-pages said "Since  strtoul()  can legitimately return 0 or ULONG_MAX
(ULLONG_MAX for strtoull()) on both success and failure, the calling program
should set errno to 0 before the call, and then determine if an error occurred
by checking whether errno has a nonzero value after the call".

So add a step to set errno to 0 before strtoull call.

Fixes: 92b9c0dedace ("ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl directly")
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/ext4_resize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 1ac51e6f..39e16529 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -35,6 +35,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	errno = 0;
 	new_size = strtoull(argv[2], &tmp, 10);
 	if ((errno) || (*tmp != '\0')) {
 		fprintf(stderr, "%s: invalid new size\n", argv[0]);
-- 
2.23.0

