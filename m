Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:59308 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbaKLXbm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 18:31:42 -0500
Received: by mail-qc0-f170.google.com with SMTP id l6so10395623qcy.29
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2014 15:31:40 -0800 (PST)
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2014 17:31:20 -0600
Message-ID: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
Subject: xfstest status on current kernels
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Is there a list somewhere of the full set of xfstests that are
expected to run (and presumably pass) on current Linux kernels for the
local file systems (ext4, btrfs and/or xfs)?

I want to make sure that I don't accidentally ignore a test (e.g. test
generic/003 doesn't run with a message " [not run] relatime not
supported by the current kernel" and want to make sure I am not
missing something).

Obviously cifs/smb3 and nfs are not going to run all the tests that
ext4, btrfs and xfs do but it is easy to leave a test out for the
wrong reasons (build dependency etc.) so want to know the list that
should run on a local Linux fs.

-- 
Thanks,

Steve
