Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726713AbfFKMPv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jun 2019 08:15:51 -0400
Date: Tue, 11 Jun 2019 08:15:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190611121546.GC2774@mit.edu>
References: <20190610173541.20511-1-krisman@collabora.com>
 <20190610173541.20511-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610173541.20511-2-krisman@collabora.com>
Sender: fstests-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 10, 2019 at 01:35:41PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported by the reference implementation
> in Ext4.
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>   [Rewrite to support feature design]
>   [Refactor to simplify implementation]

I tried out this test, and it's apparently failing for me using
e2fsprogs 1.45.2; it looks like it's a whitespace issue?

shared/012		[08:14:07][  146.388509] run fstests shared/012 at 2019-06-11 08:14:07
 [08:14:08]- output mismatch (see /results/ext4/results-4k/shared/012.out.bad)
    --- tests/shared/012.out	2019-06-10 00:02:54.000000000 -0400
    +++ /results/ext4/results-4k/shared/012.out.bad	2019-06-11 08:14:08.487418272 -0400
    @@ -1,8 +1,8 @@
     QA output created by 012
    -SCRATCH_MNT/basic           Extents, Casefold
    -SCRATCH_MNT/basic           Extents
    -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
    -SCRATCH_MNT/casefold_flag_removal Extents, Casefold
    +SCRATCH_MNT/basic                   Extents, Casefold
    +SCRATCH_MNT/basic                   Extents
    ...
    (Run 'diff -u /root/xfstests/tests/shared/012.out /results/ext4/results-4k/shared/012.out.bad'  to see the entire diff)
Ran: shared/012
Failures: shared/012
Failed 1 of 1 tests
Xunit report: /results/ext4/results-4k/result.xml

root@kvm-xfstests:~# diff -u /root/xfstests/tests/shared/012.out /results/ext4/results-4k/shared/012.out.bad
--- /root/xfstests/tests/shared/012.out	2019-06-10 00:02:54.000000000 -0400
+++ /results/ext4/results-4k/shared/012.out.bad	2019-06-11 08:14:08.487418272 -0400
@@ -1,8 +1,8 @@
 QA output created by 012
-SCRATCH_MNT/basic           Extents, Casefold
-SCRATCH_MNT/basic           Extents
-SCRATCH_MNT/casefold_flag_removal Extents, Casefold
-SCRATCH_MNT/casefold_flag_removal Extents, Casefold
+SCRATCH_MNT/basic                   Extents, Casefold
+SCRATCH_MNT/basic                   Extents
+SCRATCH_MNT/casefold_flag_removal   Extents, Casefold
+SCRATCH_MNT/casefold_flag_removal   Extents, Casefold
 SCRATCH_MNT/flag_inheritance/d1/d2/d3 Extents, Casefold
 SCRATCH_MNT/symlink/ind1/TARGET
 mv: cannot stat 'SCRATCH_MNT/rename/rename': No such file or directory
