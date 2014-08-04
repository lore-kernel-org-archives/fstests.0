Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52232 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaHDLTe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 Aug 2014 07:19:34 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so7518765wgh.10
        for <fstests@vger.kernel.org>; Mon, 04 Aug 2014 04:19:30 -0700 (PDT)
Message-ID: <53DF6C3F.6010406@plexistor.com>
Date: Mon, 04 Aug 2014 14:19:27 +0300
From: Omer Caspi <omer.caspi@plexistor.com>
MIME-Version: 1.0
Subject: generic/076 cleanup
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Boaz <boaz@plexistor.com>
List-ID: <fstests@vger.kernel.org>

While running some tests from the xfstests suite (quick group), I noticed 
that generic test 076 doesn't clean after itself. Specifically, a couple 
of directories (p1 and p2) remain on $TEST_DIR once the test is completed. 
To my understanding, a test should cleanup the files it had created, so I 
added a rm command to test's _cleanup function to fix it, which seems to 
be OK, but I thought I'll check: is there a reason for these directories 
to remain there after the test completion?

Omer
