Received: from mail-wi0-f169.google.com ([209.85.212.169]:35172 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932937AbbFWN35 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2015 09:29:57 -0400
Received: by wiga1 with SMTP id a1so106450695wig.0
        for <fstests@vger.kernel.org>; Tue, 23 Jun 2015 06:29:56 -0700 (PDT)
Received: from nowhere.localdomain ([207.232.55.62])
        by mx.google.com with ESMTPSA id dz4sm22444443wib.17.2015.06.23.06.29.54
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 06:29:54 -0700 (PDT)
Message-ID: <55895F51.2050502@plexistor.com>
Date: Tue, 23 Jun 2015 16:29:53 +0300
From: Omer Caspi <omer.caspi@plexistor.com>
MIME-Version: 1.0
Subject: IO errors in xfstests
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

Other than occasional use of dm-flakey drop writes, it looks like the xfstests 
suite doesn't test cases of faulty devices, like block device that return error 
for IO sent to it (bad sectors simulation and such).

Is it so, or am I missing something?


Thanks,
Omer
