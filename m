Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:48783 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbaIOV15 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Sep 2014 17:27:57 -0400
Received: by mail-la0-f51.google.com with SMTP id gi9so5616386lab.10
        for <fstests@vger.kernel.org>; Mon, 15 Sep 2014 14:27:55 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 15 Sep 2014 14:27:55 -0700
Message-ID: <CAN05THQcTBMdY4hMXuK-XGRAWAi843S3VmiwppvQ8tTa9ch64Q@mail.gmail.com>
Subject: SCSI test target for emulating broken/bad disk
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

List, All,

I have been working on creating a "bad disk" for use with testing.
One aim is for having an easy way to create a SCSI disk that fails in
certain controllable ways
to make sure that filesystem code or applications that talk directly
to a SCSI disk handle
error conditions and specific sense codes correctly.

To do things like :
* flag certain regions of blocks to always fail with certain sense codes
* cause i/o to certain regions cause the whole device to "hang" for some time
* torture : "fail 10% of any READs with a certain error".
* transient errors: make the next #n i/o to a range fail with a sense
code, then self-heal the device and further i/o complete without
error.


A very first prototype can be seen at :

https://github.com/rsahlberg/flaky-stgt

Please see the README.

This will probably eventually be merged back into the upstream tgt project.

Is this something you guys would find useful? If so I am more than
happy to work with
you to add what features you need or want.


Best regards, and hopefully you find this useful.
Feedback appreciated.
ronnie sahlberg
