Received: from mail-qt0-f180.google.com ([209.85.216.180]:53841 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdJJRV3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Oct 2017 13:21:29 -0400
Received: by mail-qt0-f180.google.com with SMTP id n61so25498390qte.10
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 10:21:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/2] Add fio performance tracking to fstests
Date: Tue, 10 Oct 2017 13:21:23 -0400
Message-Id: <1507656085-17101-1-git-send-email-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: kernel-team@fb.com, fstests@vger.kernel.org, david@fromorbit.com, tytso@mit.edu
List-ID: <fstests@vger.kernel.org>

Everybody agrees that a new project for performance testing is not super useful,
and that it would be better to integrate it into something we all already run.
These two patches take what was fsperf and puts it into fstests proper.  This
provides better flexibility for test environments, and at least gets us started
towards adding more of these sort of tests into our day to day activities.

The only thing extra to run these tests is the PERF_CONFIGNAME option that must
be specified in order for the perf tests to be run.  We need this (or something
like it) to make sure that we compare runs that have similar setups so that we
don't end up failing because we did one run with NVME but the next run with
SATA.

I've only added one of the fio tests from fsperf because I want to make sure
we're all happy with the generic support that I've added.  Once these are merged
I'll send the next tests along and rework how we do comparisons so we're
comparing averages of previous runs instead of just whatever the last run was.
Thanks,

Josef
